//
//  PaymentEndpoint.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation

enum PaymentEndpoint {
    case getAll(dateFrom: String, dateTo: String)
    case add(categoryId: Int, description: String?, date: String, sum: Double)
    case edit(paymentId: Int, categoryId: Int, description: String?, date: String, sum: Double)
}

extension PaymentEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getAll:
            return "/api/payment/all"
        case .add:
            return "/api/payment/"
        case .edit(let paymentId,_,_,_,_):
            return "/api/payment/\(paymentId)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAll:
            return .get
        case .add:
            return .post
        case .edit:
            return .patch
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .getAll(let dateFrom, let dateTo):
            return [
                "dateStart": dateFrom,
                "dateEnd": dateTo
            ]
        default: return nil
        }
    }
    
    var body: Any? {
        switch self {
        case .add(let categoryId, let description, let date, let sum):
            var params: [String:Any] = [:]
            params["category"] = categoryId
            params["description"] = description
            params["date"] = date
            params["sum"] = sum
            return params
        case .edit(_, let categoryId, let description, let date, let sum):
            var params: [String:Any] = [:]
            params["category"] = categoryId
            params["description"] = description
            params["date"] = date
            params["sum"] = sum
            return params
        default:
            return nil
        }
    }
    
    
}
