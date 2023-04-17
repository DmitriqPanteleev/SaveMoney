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
    let apiService: RegistrationApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: RegistrationApiProtocol) {
        self.apiService = apiService
        
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
        bindSaveTap()
    }
    
    func bindEmail() {
        input.onChangeEmail
            .sink { [weak self] in
                self?.output.email = $0
            }
            .store(in: &cancellable)
    }
    
    func bindPassword() {
        input.onChangePassword
            .sink { [weak self] in
                self?.output.password = $0
            }
            .store(in: &cancellable)
    }
    
    func bindSurname() {
        input.onChangeSurname
            .sink { [weak self] in
                self?.output.surname = $0
            }
            .store(in: &cancellable)
    }
    
    func bindName() {
        input.onChangeName
            .sink { [weak self] in
                self?.output.name = $0
            }
            .store(in: &cancellable)
    }
    
    func bindPhone() {
        input.onChangePhone
            .sink { [weak self] in
                self?.output.phone = $0
            }
            .store(in: &cancellable)
    }
    
    func bindSaveTap() {
        let request = input.onSaveTap
            .map { [unowned self] in
                Future {
                    try await self.apiService.registration(email: self.output.email,
                                                           password: self.output.password,
                                                           name: self.output.name,
                                                           surname: self.output.surname,
                                                           phone: self.output.phone)
                }
                .materialize()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
        
        request
            .failures()
            .sink { [weak self] error in
                print(error)
            }
            .store(in: &cancellable)
            
        request
            .values()
            .sink { [weak self] s in
                
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
        
        let onSaveTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .content
        
        var email = ""
        var password = ""
        var surname = ""
        var name = ""
        var phone = ""
        
        var isButtonDisabled = true
        var isShowingErrorAlert = false
    }
}
