//
//  PaymentService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation

protocol PaymentAddApiProtocol {
    func addPayment(categoryId: Int, description: String?, date: String, sum: Double) async throws
}

protocol PaymentEditApiProtocol {
    func editPayment(paymentId: Int, categoryId: Int, description: String?, date: String, sum: Double) async throws
}

protocol AnalizeApiProtocol {
    func getAllPaymens(from date: String, to endDate: String) async throws -> [Payment]
    func getAnalizeCategories(dateFrom: String, dateTo: String) async throws -> [AnalizeCategory]
}

protocol PaymentAddEditApiProtocol: PaymentAddApiProtocol, PaymentEditApiProtocol { }

struct PaymentApiService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

extension PaymentApiService: PaymentAddApiProtocol {
    func addPayment(categoryId: Int, description: String?, date: String, sum: Double) async throws {
        let _ = try await self.client.sendRequest(endpoint: PaymentEndpoint.add(categoryId: categoryId,
                                                                                description: description,
                                                                                date: date,
                                                                                sum: sum),
                                                  responseModel: ServerResponse<ServerPayment>.self)
    }
}

extension PaymentApiService: PaymentEditApiProtocol {
    func editPayment(paymentId: Int, categoryId: Int, description: String?, date: String, sum: Double) async throws {
        let _ = try await self.client.sendRequest(endpoint: PaymentEndpoint.edit(paymentId: paymentId,
                                                                                 categoryId: categoryId,
                                                                                 description: description,
                                                                                 date: date,
                                                                                 sum: sum),
                                                  responseModel: EmptyResponse.self)
    }
}

extension PaymentApiService: AnalizeApiProtocol {
    func getAllPaymens(from date: String, to endDate: String) async throws -> [Payment] {
        let data = try await self.client.sendRequest(endpoint: PaymentEndpoint.getAll(dateFrom: date,
                                                                                      dateTo: endDate),
                                                     responseModel: PaymentResponse<[ServerPayment]>.self).data
        return PaymentModelMapper().toLocal(list: data)
    }
    
    func getAnalizeCategories(dateFrom: String, dateTo: String) async throws -> [AnalizeCategory] {
        let data = try await self.client.sendRequest(endpoint: AnalyticEndpoint.getAnalizeCategories(dateFrom: dateFrom,
                                                                                                     dateTo: dateTo),
                                                     responseModel: PaymentResponse<[ServerAnalyticCategory]>.self).data
        
        return AnalizeCategoryModelMapper().toLocal(list: data)
    }
}

extension PaymentApiService: PaymentAddEditApiProtocol {}
