//
//  CreateProfileViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation
import Combine
import CombineExt

final class CreateProfileViewModel: ObservableObject {
    
    // MARK: Services
    private let apiService: CommonSignApiProtocol
    private weak var router: CreateProfileRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: CommonSignApiProtocol, router: CreateProfileRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension CreateProfileViewModel {
    func bind() {
        bindEmail()
        bindPassword()
        bindSurname()
        bindName()
        bindPhone()
        bindSignState()
        bindSaveTap()
    }
    
    func bindEmail() {
        input.onChangeEmail
            .handleEvents(receiveOutput: { [weak self] in
                if $0.correctEmail() {
                    self?.output.emailState = .success
                } else {
                    self?.output.emailState = .editing
                }
            })
            .sink { [weak self] in
                self?.output.email = $0
            }
            .store(in: &cancellable)
    }
    
    func bindPassword() {
        input.onChangePassword
            .handleEvents(receiveOutput: { [weak self] in
                if $0.count >= 8 {
                    self?.output.passwordState = .success
                } else {
                    self?.output.passwordState = .editing
                }
            })
            .sink { [weak self] in
                self?.output.password = $0
            }
            .store(in: &cancellable)
    }
    
    func bindSurname() {
        input.onChangeSurname
            .handleEvents(receiveOutput: { [weak self] in
                if $0.count >= 2 {
                    self?.output.surnameState = .success
                } else {
                    self?.output.surnameState = .editing
                }
            })
            .sink { [weak self] in
                self?.output.surname = $0
            }
            .store(in: &cancellable)
    }
    
    func bindName() {
        input.onChangeName
            .handleEvents(receiveOutput: { [weak self] in
                if $0.count >= 2 {
                    self?.output.nameState = .success
                } else {
                    self?.output.nameState = .editing
                }
            })
            .sink { [weak self] in
                self?.output.name = $0
            }
            .store(in: &cancellable)
    }
    
    func bindPhone() {
        input.onChangePhone
            .handleEvents(receiveOutput: { [weak self] in
                if $0.toServerPhone().count == 11 {
                    self?.output.phoneState = .success
                } else {
                    self?.output.phoneState = .editing
                }
            })
            .sink { [weak self] in
                self?.output.phone = $0
            }
            .store(in: &cancellable)
    }
    
    func bindSaveTap() {
        let request = input.onSaveTap
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.output.screenState = .processing
            })
            .map { [unowned self] state in
                switch state {
                case .signUp:
                    return Future {
                        try await self.apiService.registration(email: self.output.email,
                                                               password: self.output.password,
                                                               name: self.output.name,
                                                               surname: self.output.surname,
                                                               phone: self.output.phone.toServerPhone())
                    }
                    .materialize()
                case .signIn:
                    return Future {
                        try await self.apiService.login(email: self.output.email,
                                                        password: self.output.password)
                    }
                    .materialize()
                }
            }
            .switchToLatest()
            .share()
            .receive(on: DispatchQueue.main)
        
        request
            .failures()
            .sink { [weak self] error in
                if let error = error as? RequestError {
                    print(error)
                    switch error {
                    case let .unexpectedStatusCode(_, message):
                        if let message = message {
                            self?.output.errorMessage = message
                            self?.output.isShowingErrorAlert = true
                        }
                    default:
                        break
                    }
                } else {
                    self?.output.errorMessage = "Что-то пошло не так. Проверьте введенные данные"
                    self?.output.isShowingErrorAlert = true
                }
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink { [weak self] response in
                self?.router?.pushToCreatePin(with: Token(accessToken: response.token))
            }
            .store(in: &cancellable)
    }
    
    func bindSignState() {
        input.onChangeTab
            .sink { [weak self] in
                self?.output.signState = $0
            }
            .store(in: &cancellable)
    }
}

extension CreateProfileViewModel {
    struct Input {
        let onChangeEmail = PassthroughSubject<String, Never>()
        let onChangePassword = PassthroughSubject<String, Never>()
        let onChangeSurname = PassthroughSubject<String, Never>()
        let onChangeName = PassthroughSubject<String, Never>()
        let onChangePhone = PassthroughSubject<String, Never>()
        
        let onChangeTab = PassthroughSubject<SigningState, Never>()
        let onSaveTap = PassthroughSubject<SigningState, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .content
        var signState: SigningState = .signIn
        var selectionState = 0
        
        var email = ""
        var password = ""
        var surname = ""
        var name = ""
        var phone = ""
        
        var emailState: TextFieldState = .editing
        var passwordState: TextFieldState = .editing
        var surnameState: TextFieldState = .editing
        var nameState: TextFieldState = .editing
        var phoneState: TextFieldState = .editing
        
        var isShowingErrorAlert = false
        
        var errorMessage = ""
    }
}

enum SigningState: Hashable {
    case signIn
    case signUp
    
    var buttonMessage: Strings {
        switch self {
        case .signIn:
            return .signIn
        case .signUp:
            return .signUp
        }
    }
}
