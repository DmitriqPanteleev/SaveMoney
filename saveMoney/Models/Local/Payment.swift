//
//  Payment.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI


// TODO: надо получать всю analize category, чтобы отрисовывать красиво
struct Payment: Identifiable {
    let id: Int
    let description: String
    let date: Date?
    let sum: Int
    let category: String
    let categoryColor: Color
    
    var formattedSum: String {
        "\(sum) ₽"
    }
    
    // TODO: - date formatters
    var formattedDate: String {
        ""
    }
    
    static func empty() -> Payment {
        Payment(id: UUID().hashValue,
                description: "",
                date: .now,
                sum: 0,
                category: "",
                categoryColor: .black)
    }
    
    static func mock() -> Payment {
        Payment(id: 1,
                description: "На булочки",
                date: .now,
                sum: 200,
                category: "Еда",
                categoryColor: .init(hex: "38243D"))
    }
    
    static func mock2() -> Payment {
        Payment(id: 2,
                description: "",
                date: .now,
                sum: 800,
                category: "Еда",
                categoryColor: .init(hex: "38243D"))
    }
    
    static func mock3() -> Payment {
        Payment(id: 3,
                description: "ЖКХ",
                date: .now,
                sum: 2200,
                category: "Жилье",
                categoryColor: .init(hex: "AD70BD"))
    }
}
