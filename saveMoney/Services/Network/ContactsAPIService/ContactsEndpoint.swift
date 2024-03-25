//
//  ContactsEndpoint.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

enum ContactsEndpoint {
    case getAllContacts
    case addContact(phone: String, nick: String)
    case deleteContact(id: Int)
    case editNickname(id: Int, nick: String)
}

extension ContactsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getAllContacts:
            return "/api/contact/all"
        case .addContact:
            return "/api/contact/create"
        case .deleteContact(let id):
            return "/api/contact/\(id)"
        case .editNickname(let id, _):
            return "/api/contact/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllContacts:
            return .get
        case .addContact:
            return .post
        case .deleteContact:
            return .delete
        case .editNickname:
            return .patch
        }
    }
    
    var body: Any? {
        switch self {
        case .addContact(let phone, let nick):
            var params: [String:String] = [:]
            params["phone"] = phone
            params["nick"] = nick
            return params
        case .editNickname(_, let nick):
            return ["nick":nick]
        default:
            return nil
        }
    }
}
