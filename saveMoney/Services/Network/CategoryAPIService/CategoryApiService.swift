//
//  CategoryService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

protocol AllCategoryApiProtocol {
    func getAllCategories() async throws -> [Category]
    func deleteCategory(id: Int) async throws
}

protocol AddEditCategoryProtocol {
    func addCategory(name: String, color: String) async throws
    func editCategory(id: Int, name: String, color: String) async throws
}

struct CategoryApiService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

extension CategoryApiService: AddEditCategoryProtocol {
    func addCategory(name: String, color: String) async throws {
        let _ = try await self.client.sendRequest(endpoint: CategoryEndpoint.add(name: name,
                                                                                 color: color),
                                                  responseModel: EmptyResponse.self)
    }
    
    func editCategory(id: Int, name: String, color: String) async throws {
        let _ = try await self.client.sendRequest(endpoint: CategoryEndpoint.edit(id: id,
                                                                                  name: name,
                                                                                  color: color),
                                                  responseModel: EmptyResponse.self)
    }
}

extension CategoryApiService: AllCategoryApiProtocol {
    func deleteCategory(id: Int) async throws {
        let _ = try await self.client.sendRequest(endpoint: CategoryEndpoint.delete(id: id),
                                                  responseModel: EmptyResponse.self)
    }
    
    func getAllCategories() async throws -> [Category] {
        let data = try await self.client.sendRequest(endpoint: CategoryEndpoint.getAll,
                                                     responseModel: ServerResponse<[ServerCategory]>.self).data
        return CategoryModelMapper().toLocal(list: data)
    }
}
