//
//  SubmitPinCodeViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation
import Combine
import CombineExt

final class SubmitPinCodeViewModel: ObservableObject {
    
    // MARK: - Services
    private let keychainManager: KeychainManger
    private let biometricService: BiometricAuthenticationService
    private weak var router: SubmitPinRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(keychainManager: KeychainManger,
         biometricService: BiometricAuthenticationService,
         router: SubmitPinRouter?) {
        self.keychainManager = keychainManager
        self.biometricService = biometricService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension SubmitPinCodeViewModel {
    func bind() {
        bindPin()
        bindBiometry()
        bindBiometryAvaliable()
    }
    
    func bindBiometryAvaliable() {
        input.onAppear
            .map { [weak self] in
                self?.biometricService.isFaceIdAvaliable
            }
            .compactMap { $0 }
            .sink { [weak self] in
                self?.output.isBiometryAvaliable = $0
            }
            .store(in: &cancellable)
    }
    
    func bindPin() {
        input.onChangePin
            .handleEvents(receiveOutput: { [weak self] in
                guard let self = self else { return }
                
                if self.output.pin.count < 4 {
                    self.output.pin += $0
                }
            })
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.output.pin.count == 4
            }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.output.pin == self.keychainManager.userPinCode
            }
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let token = self.keychainManager.token {
                    self.router?.closeCoordinator(with: Token(accessToken: token))
                }
            }
            .store(in: &cancellable)
        
        input.onErasePin
            .filter { [weak self] in
                guard let self = self else { return false }
                return self.output.pin.count > 0
            }
            .sink { [weak self] in
                self?.output.pin.removeLast()
            }
            .store(in: &cancellable)
    }
    
    func bindBiometry() {
        let biometricRequest = input.onFaceIdTap
            .map { [unowned self] in
                Future {
                    try await self.biometricService.requestBiometricUnlock()
                }
                .materialize()
            }
            .switchToLatest()
            .share()
            .receive(on: DispatchQueue.main)
        
        biometricRequest
            .failures()
            .sink { error in
                if let error = error as? BiometricAuthenticationError {
                    switch error {
                    case .noFaceIdEnrolled:
                        self.output.alertMessage = error.errorDescription.rawValue.localized(.russian)
                    default:
                        self.output.alertMessage = error.errorDescription.rawValue.localized(.russian)
                    }
                    self.output.isShowAlert = true
                }
            }
            .store(in: &cancellable)
        
        biometricRequest
            .values()
            .filter { $0 }
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let token = self.keychainManager.token {
                    self.router?.closeCoordinator(with: Token(accessToken: token))
                }
            }
            .store(in: &cancellable)
    }
}

extension SubmitPinCodeViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onChangePin = PassthroughSubject<String, Never>()
        let onErasePin = PassthroughSubject<Void, Never>()
        let onFaceIdTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .content
        
        var pin = ""
        var username = ""
        var alertMessage = ""
        var isShowAlert = false
        var isBiometryAvaliable = false
    }
}

