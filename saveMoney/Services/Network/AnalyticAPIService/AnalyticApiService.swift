//
//  AnalyticApiService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

protocol AllAnalyticApiProtocol {
    func getAnalizeCategories(dateFrom: String, dateTo: String) async throws -> [AnalizeCategory]
    func getAllPaymens(from date: String, to endDate: String) async throws -> [Payment]
}

struct AnalyticApiService {
    let client: HTTPClient
}

extension AnalyticApiService: AllAnalyticApiProtocol {
    func getAnalizeCategories(dateFrom: String, dateTo: String) async throws -> [AnalizeCategory] {
        let data = try await self.client.sendRequest(endpoint: AnalyticEndpoint.getAnalizeCategories(dateFrom: dateFrom,
                                                                                                     dateTo: dateTo),
                                                     responseModel: ServerResponse<[ServerAnalyticCategory]>.self).data
        
        return AnalizeCategoryModelMapper().toLocal(list: data)
    }
    
    func getAllPaymens(from date: String, to endDate: String) async throws -> [Payment] {
        let data = try await self.client.sendRequest(endpoint: PaymentEndpoint.getAll(dateFrom: date,
                                                                                      dateTo: endDate),
                                                     responseModel: ServerResponse<[ServerPayment]>.self).data
        return PaymentModelMapper().toLocal(list: data)
    }
}
