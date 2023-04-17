//
//  ServerResponse.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    let data: T
}

struct LogoutResponse: Codable {
    let message: String?
}
