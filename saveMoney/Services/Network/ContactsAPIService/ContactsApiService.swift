//
//  ContactsApiService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

struct ContactsApiService {
    let client: HTTPClient
}

extension ContactsApiService {
    func getAllContacts() async throws -> [Contact] {
        let data = try await self.client.sendRequest(endpoint: ContactsEndpoint.getAllContacts,
                                                     responseModel: ServerResponse<[ServerContact]>.self).data
        return ContactModelMapper().toLocal(list: data)
    }
    
    func addContact(phone: String, nick: String) async throws {
        let _ = try await self.client.sendRequest(endpoint: ContactsEndpoint.addContact(phone: phone,
                                                                                        nick: nick),
                                                  responseModel: EmptyResponse.self)
    }
    
    func deleteContact(id: Int) async throws {
        let _ = try await self.client.sendRequest(endpoint: ContactsEndpoint.deleteContact(id: id),
                                                  responseModel: EmptyResponse.self)
    }
    
    func editNickname(id: Int, nick: String) async throws {
        let _ = try await self.client.sendRequest(endpoint: ContactsEndpoint.editNickname(id: id,
                                                                                          nick: nick),
                                                  responseModel: EmptyResponse.self)
    }
}
