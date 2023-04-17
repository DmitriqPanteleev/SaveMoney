//
//  AuthenticationService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

protocol AuthApiProtocol {
    func login(email: String, password: String) async throws -> RegistrationResponse
}

protocol RegistrationApiProtocol {
    func registration(email: String,
                      password: String,
                      name: String,
                      surname: String,
                      phone: String) async throws -> RegistrationResponse
    
}

protocol ProfileApiProtocol {
    func changePassword(newPassword: String) async throws
    func logOut() async throws -> String
}

struct AuthenticationService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

extension AuthenticationService: AuthApiProtocol {
    func login(email: String, password: String) async throws -> RegistrationResponse {
        try await self.client.sendRequest(endpoint: AuthenticationEndpoint.login(email: email, password: password),
                                responseModel: RegistrationResponse.self)
    }
}

extension AuthenticationService: RegistrationApiProtocol {
    func registration(email: String,
                      password: String,
                      name: String,
                      surname: String,
                      phone: String) async throws -> RegistrationResponse {
        try await self.client.sendRequest(endpoint: AuthenticationEndpoint.registr(email: email,
                                                                                   password: password,
                                                                                   name: name,
                                                                                   surname: surname,
                                                                                   phone: phone),
                                          responseModel: RegistrationResponse.self)
    }
}

extension AuthenticationService: ProfileApiProtocol {
    func changePassword(newPassword: String) async throws {
        let _ = try await self.client.sendRequest(endpoint: AuthenticationEndpoint.changePassword(newPassword: newPassword),
                                          responseModel: EmptyResponse.self)
    }
    
    func logOut() async throws -> String {
        let msg = try await self.client.sendRequest(endpoint: AuthenticationEndpoint.logout,
                                                    responseModel: ServerResponse<LogoutResponse>.self).data.message
        return msg ?? ""
    }
    
    
}
