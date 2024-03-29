//
//  EnterCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//
import SwiftUI
import Stinsen
import Combine

final class AuthorizationCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \AuthorizationCoordinator.pinCode)
    
    @Root var pinCode = makePinCode
    
    private let keychainManager: KeychainManger
    private let biometricService = DIContainer.shared.container.resolve(BiometricAuthenticationService.self)!
    let authorizationState: CurrentValueSubject<AuthorizationState, Never>
    
    init(keychainManager: KeychainManger,
         authorizationState: CurrentValueSubject<AuthorizationState, Never>) {
        self.keychainManager = keychainManager
        self.authorizationState = authorizationState
    }
    
    deinit {
        print("Coordinator \(self) IS DEINITED")
    }
}

extension AuthorizationCoordinator {
    @ViewBuilder func makePinCode() -> some View {
        let viewModel = SubmitPinCodeViewModel(keychainManager: keychainManager,
                                               biometricService: biometricService,
                                               router: self)
        SubmitPinCodeView(viewModel: viewModel)
    }
}
