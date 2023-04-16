//
//  ServerResponse.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

struct ServerResponse<T: Decodable>: Decodable {
    let data: T
}
