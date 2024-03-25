//
//  User.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.03.2023.
//

import Foundation

struct User: Identifiable {
    let id: Int
    let name: String
    let surname: String
    let email: String
    let phone: String
    
    static func mock() -> User {
        User(id: 1,
             name: "Дмитрий",
             surname: "Пантелеев",
             email: "panteleev@gmail.com",
             phone: "89271653040")
    }
}
