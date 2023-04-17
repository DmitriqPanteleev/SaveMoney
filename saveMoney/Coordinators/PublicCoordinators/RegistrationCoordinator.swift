//
//  RegistrationCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import SwiftUI
import Stinsen
import Combine

final class RegistrationCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<RegistrationCoordinator>(initial: \.createProfile)
    
    @Root var createProfile = makeCreateProfile
    @Route(.push) var createPin = makeCreatePin
    
    let authorizationState: CurrentValueSubject<AuthorizationState, Never>
    private let keychainManager: PinManagerProtocol
    private let apiService = AuthenticationService(client: HTTPClientImpl())
    
    init(authorizationState: CurrentValueSubject<AuthorizationState, Never>,
         keychainManager: PinManagerProtocol) {
        self.authorizationState = authorizationState
        self.keychainManager = keychainManager
    }
    
    #if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
    #endif
}

extension RegistrationCoordinator {
    @ViewBuilder func makeCreateProfile() -> some View {
        let viewModel = CreateProfileViewModel(apiService: apiService, router: self)
        CreateProfileView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeCreatePin(token: Token) -> some View {
        let viewModel = CreatePinViewModel(keychainManager: keychainManager,
                                           token: token,
                                           router: self)
    }
}
