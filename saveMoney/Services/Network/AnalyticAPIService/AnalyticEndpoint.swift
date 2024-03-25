//
//  AnalyticEndpoint.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

enum AnalyticEndpoint {
    case getAnalizeCategories(dateFrom: String, dateTo: String)
}

extension AnalyticEndpoint: Endpoint {
    var path: String {
        return "/api/payment/analiz"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: Any? {
        return nil
    }
    
    var query: [String : String]? {
        switch self {
        case .getAnalizeCategories(let dateFrom, let dateTo):
            var params: [String:String] = [:]
            params["dateStart"] = dateFrom
            params["dateEnd"] = dateTo
            return params
        }
    }
}
