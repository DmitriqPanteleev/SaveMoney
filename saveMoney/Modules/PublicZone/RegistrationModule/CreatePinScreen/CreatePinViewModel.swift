//
//  CreatePinViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation
import Combine

final class CreatePinViewModel: ObservableObject {
    
    // MARK: - Services
    private var keychainManager: PinManagerProtocol
    private weak var router: CreatePinRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - External
    private var token: Token
    
    init(keychainManager: PinManagerProtocol, token: Token, router: CreatePinRouter?) {
        self.keychainManager = keychainManager
        self.router = router
        self.token = token
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
    
}

private extension CreatePinViewModel {
    func bind() {
        bindPin()
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
                self?.output.pin.count == 4
            }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.output.isShowPopup = true
                self?.output.isPadDisabled = true
            })
            .delay(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.keychainManager.userPinCode = self.output.pin
                self.router?.closeCoordinator(with: self.token)
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
}

extension CreatePinViewModel {
    struct Input {
        let onChangePin = PassthroughSubject<String, Never>()
        let onErasePin = PassthroughSubject<Void, Never>()
        let onSave = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var pin = ""
        var isPadDisabled = false
        var isShowPopup = false
    }
}
