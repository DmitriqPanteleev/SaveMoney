//
//  ServerCategory.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

struct ServerCategory: Codable {
    let id: Int
    let name: String?
    let color: String?
    let isCustom: Bool?
}
