//
//  Contact.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import Foundation

struct Contact: Identifiable {
    let id: Int
    let nickname: String
    let phoneNumber: String
    
    init(id: Int, nickname: String, phoneNumber: String) {
        self.id = id
        self.nickname = nickname
        self.phoneNumber = phoneNumber
    }
    
    init(nickname: String, phoneNumber: String) {
        self.id = UUID().hashValue
        self.nickname = nickname
        self.phoneNumber = phoneNumber
    }
    
    // TODO: regex for ru phone nummbers (temporary optional)
    var formattedNumber: String?
    
    static func mock() -> Contact {
        Contact(id: 1,
                nickname: "Коза мелкая",
                phoneNumber: "89676694131")
    }
    
    static func mock2() -> Contact {
        Contact(id: 2,
                nickname: "Какое-то очень длинное имя, придуманное явно ебланом",
                phoneNumber: "89271653040")
    }
    
    static func mock3() -> Contact {
        Contact(id: 3,
                nickname: "Левый чел",
                phoneNumber: "89372622737")
    }
}
