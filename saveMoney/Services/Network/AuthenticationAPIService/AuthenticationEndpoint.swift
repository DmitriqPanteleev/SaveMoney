//
//  AuthenticationEndpoint.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

enum AuthenticationEndpoint {
    case registr(email: String,
                 password: String,
                 name: String,
                 surname: String,
                 phone: String)
    case login(email: String, password: String)
    case logout
    case changePassword(newPassword: String)
}

extension AuthenticationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .registr:
            return "api/security/registarion"
        case .login:
            return "api/security"
        case .logout:
            return "api/security/logout"
        case .changePassword:
            return "api/security/changePassword"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .registr, .login:
            return .post
        case .logout:
            return .get
        case .changePassword:
            return .patch
        }
    }
    
    var body: Any? {
        switch self {
        case .registr(let email, let password, let name, let surname, let phone):
            var params: [String: String] = [:]
            params["username"] = email
            params["password"] = password
            params["name"] = name
            params["surname"] = surname
            params["phone"] = phone
            return params
        case .login(let email, let password):
            var params: [String: String] = [:]
            params["username"] = email
            params["password"] = password
            return params
        case .changePassword(let newPassword):
            return ["newPassword":newPassword]
        default: return nil
        }
    }
}
