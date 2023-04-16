//
//  AuthManager.swift
//
//
//  Created by Дмитрий Яровой on 11/29/22.
//

import Foundation
import Combine

actor ConnectionManager {
    private let monitor = NetworkMonitor()
    
    init() {}
    
    func checkConnection() async throws -> Bool {
        while monitor.isNotConnected { }
        return monitor.isNotConnected
    }
}

actor AuthManager {
    private var keychainManager: KeychainManagerProtocol
    private let service: Refreshable
    private var refreshTask: Task<AuthToken, Error>?
    
    let authorizationState: CurrentValueSubject<AuthorizationState, Never>
    
    init(keychainManager: KeychainManagerProtocol,
                refreshService: Refreshable,
                authorizationState: CurrentValueSubject<AuthorizationState, Never>) {
        self.keychainManager = keychainManager
        self.service = refreshService
        self.authorizationState = authorizationState
    }
    
    func validToken() async throws -> AuthToken? {
        if let handle = refreshTask {
            return try await handle.value
        }
        
        guard let accessToken: String = keychainManager.token,
              let expiresIn: Double = keychainManager.tokenExpiresIn,
              let refreshToken: String =  keychainManager.refreshToken else {
            return nil
        }
        
        let token = AuthToken(accessToken: accessToken,
                              refreshToken: refreshToken,
                              expiresIn: expiresIn)
        
        if token.isValid {
            return token
        }

        return try await self.refreshToken()
    }
    
    func refreshToken() async throws -> AuthToken {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> AuthToken in
            defer { refreshTask = nil }
            
            let refreshToken = keychainManager.refreshToken ?? ""
            let accessToken = keychainManager.token
            
            do {
                let token = try await service.refresh(withRefreshToken: refreshToken, accessToken: accessToken)
                
                keychainManager.token = token.accessToken
                keychainManager.tokenExpiresIn = token.expiresIn
                keychainManager.refreshToken = token.refreshToken
                try await Task.sleep(nanoseconds: 500000000)
                return token
            } catch {
                authorizationState.send(.unauthorized)
                guard let requestError = error as? RequestError else {
                    throw RequestError.unknown
                }
                throw requestError
            }
            
        }
        self.refreshTask = task
        return try await task.value
    }
}
