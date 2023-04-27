//
//  ServerContact.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

struct ServerContact: Codable {
    let id: Int
    let phone: String?
    let nick: String?
}
