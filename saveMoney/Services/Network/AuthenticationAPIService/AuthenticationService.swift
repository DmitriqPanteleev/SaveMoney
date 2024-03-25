//
//  AuthenticationService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

protocol LoginApiProtocol {
    func login(email: String, password: String) async throws -> RegistrationModel
}

protocol RegistrationApiProtocol {
    func registration(email: String,
                      password: String,
                      name: String,
                      surname: String,
                      phone: String) async throws -> RegistrationModel
    
}

protocol CommonSignApiProtocol: LoginApiProtocol, RegistrationApiProtocol {
    
}

protocol ProfileApiProtocol {
    func changePassword(newPassword: String) async throws
    func logOut() async throws -> String
}

struct AuthenticationApiService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

extension AuthenticationApiService: LoginApiProtocol {
    func login(email: String, password: String) async throws -> RegistrationModel {
        let response = try await self.client.sendRequest(endpoint: AuthenticationEndpoint.login(email: email, password: password),
                                responseModel: RegistrationResponse.self)
        return RegistrationModelMapper().toLocal(serverEntity: response)
    }
}

extension AuthenticationApiService: RegistrationApiProtocol {
    func registration(email: String,
                      password: String,
                      name: String,
                      surname: String,
                      phone: String) async throws -> RegistrationModel {
       let response = try await self.client.sendRequest(endpoint: AuthenticationEndpoint.registr(email: email,
                                                                                   password: password,
                                                                                   name: name,
                                                                                   surname: surname,
                                                                                   phone: phone),
                                          responseModel: RegistrationResponse.self)
        
        return RegistrationModelMapper().toLocal(serverEntity: response)
    }
}

extension AuthenticationApiService: ProfileApiProtocol {
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

extension AuthenticationApiService: CommonSignApiProtocol { }
