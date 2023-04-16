//
//  RefreshTokenEndpoint.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation

enum RefreshTokenEndpoint {
    case refreshToken(withRefreshToken: String)
}

extension RefreshTokenEndpoint: Endpoint {
        
    var path: String {
        switch self {
        case .refreshToken:
            return "" //TODO: - указать путь
        }
    }

    var method: RequestMethod {
        switch self {
        case .refreshToken:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .refreshToken:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: Any? {
        switch self {
        case let .refreshToken(withRefreshToken: token):
            var params = [String: String]()
            params["refresh_token"] = token
            return params
        }
    }
}
