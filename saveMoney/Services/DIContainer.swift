//
//  DIContainer.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation
import Combine
import Swinject

final class DIContainer {
    static let shared = DIContainer()
    
    var container: Container {
        get {
            if _container == nil {
                _container = build()
            }
            return _container!
        }
        set {
            _container = newValue
        }
    }
    
    private var _container: Container?
    
    private func build() -> Container {
        let container = Container()
        
        container.register(KeychainManger.self) { r in
            return KeychainManger(serviceName: KeychainKeyStorage.get())
        }
        .inObjectScope(.container)
        
        container.register(CurrentValueSubject<AuthorizationState, Never>.self) { r in
            return CurrentValueSubject<AuthorizationState, Never>(.unauthorized)
        }
        .inObjectScope(.container)
        
        container.register(Refresher.self) { r in
            return Refresher()
        }.inObjectScope(.container)
        
        container.register(HTTPClientImpl.self) { r in
            return HTTPClientImpl()
        }
        
        container.register(AuthManager.self) { r in
            let keychainManager = r.resolve(KeychainManger.self)!
            let refresher = r.resolve(Refresher.self)!
            let authState = r.resolve(CurrentValueSubject<AuthorizationState, Never>.self)!
            
            return AuthManager(keychainManager: keychainManager,
                        refreshService: refresher,
                        authorizationState: authState)
        }.inObjectScope(.container)
        
        container.register(HTTPClientAuthImpl.self) { r in
            let authManager = r.resolve(AuthManager.self)!
            return HTTPClientAuthImpl(authManager: authManager)
        }
        
        container.register(AuthenticationApiService.self) { r in
            let client = r.resolve(HTTPClientImpl.self)!
            return AuthenticationApiService(client: client)
        }
        
        container.register(ContactsApiService.self) { r in
            let client = r.resolve(HTTPClientAuthImpl.self)!
            return ContactsApiService(client: client)
        }
        
        container.register(PaymentApiService.self) { r in
            let client = r.resolve(HTTPClientAuthImpl.self)!
            return PaymentApiService(client: client)
        }
        
        container.register(CategoryApiService.self) { r in
            let client = r.resolve(HTTPClientAuthImpl.self)!
            return CategoryApiService(client: client)
        }
        
        container.register(AnalyticApiService.self) { r in
            let client = r.resolve(HTTPClientAuthImpl.self)!
            return AnalyticApiService(client: client)
        }
        
        container.register(BiometricAuthenticationService.self) { r in
            return BiometricAuthenticationService()
        }
        
        container.register(ContactsManager.self) { r in
            return ContactsManager()
        }
        
        return container
    }
}

