//
//  CategoryEndpoint.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

enum CategoryEndpoint {
    case add(name: String, color: String)
    case edit(id: Int, name: String, color: String)
    case delete(id: Int)
    case getAll
}

extension CategoryEndpoint: Endpoint {
    var path: String {
        switch self {
        case .add:
            return "/api/category/create"
        case .edit(let id,_,_), .delete(let id):
            return "/api/category/\(id)"
        case .getAll:
            return "/api/category/all"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .add:
            return .post
        case .edit:
            return .patch
        case .delete:
            return .delete
        case .getAll:
            return .get
        }
    }
    
    var body: Any? {
        switch self {
        case .add(let name, let color), .edit(_, let name, let color):
            var params: [String:String] = [:]
            params["name"] = name
            params["color"] = color
            return params
        default: return nil
        }
    }
    
    
}
