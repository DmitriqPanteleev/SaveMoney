//
//  RegistrationResponse.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

struct RegistrationResponse: Codable {
    let email: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "user"
        case token
    }
}
