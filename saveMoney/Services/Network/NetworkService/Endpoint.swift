//
//  Endpoint.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation

protocol Endpoint {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var query: [String: String]? { get }
    var body: Any? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        "saveumoney.ru"
    }
    
    var query: [String : String]? {
        nil
    }
    
    var header: [String: String]? {
        return [
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
}

