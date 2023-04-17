//
//  MainCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import SwiftUI
import Stinsen
import Combine

final class AppCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<AppCoordinator>
    
    @Root var authorization = makeAuthorization
    @Root var registration = makeRegistration
    @Root var tabBar = makeTabBar
    
    private let authorizationState = CurrentValueSubject<AuthorizationState, Never>(.unauthorized)
    private let keychainService = KeychainManger(serviceName: KeychainKeyStorage.get())
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        if let _ = keychainService.token {
            stack = NavigationStack(initial: \AppCoordinator.tabBar)
        } else {
            if PinCodeManager.shared.pinCode.isEmpty {
                stack = NavigationStack(initial: \AppCoordinator.registration)
            } else {
                stack = NavigationStack(initial: \AppCoordinator.authorization)
            }
        }
        
        authorizationState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .unauthorized:
                    self.saveToken(token: nil)
                    if PinCodeManager.shared.pinCode.isEmpty {
                        self.root(\.registration)
                    } else {
                        self.root(\.authorization)
                    }
                case .authorized(let token):
                    if let token = token {
                        self.saveToken(token: token)
                    }
                    self.root(\.tabBar)
                }
            }
            .store(in: &cancellable)
    }
    
    private func saveToken(token: Token?) {
        if let token = token {
            self.keychainService.token = token.accessToken
        } else {
            self.keychainService.token = nil
        }
    }
}

extension AppCoordinator {
    func makeAuthorization() -> some View {
        Text("Авторизация")
    }
    
    func makeRegistration() -> NavigationViewCoordinator<RegistrationCoordinator> {
        NavigationViewCoordinator(RegistrationCoordinator(authorizationState: authorizationState,
                                                          keychainManager: keychainService))
    }
    
    func makeTabBar() -> some View {
        Text("Таббар")
    }
}
