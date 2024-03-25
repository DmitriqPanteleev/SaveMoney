//
//  Payment.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI

struct Payment: Identifiable {
    let id: Int
    let description: String
    let date: Date
    let sum: Int
    let categoryId: Int
    let categoryName: String
    let categoryColor: Color
    
    var formattedSum: String {
        "\(sum.separatedNumber) ₽"
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
                categoryId: 1,
                categoryName: "",
                categoryColor: .black)
    }
    
    static func emptyWithSum(_ sum: Int, _ date: Date) -> Payment {
        Payment(id: UUID().hashValue,
                description: "",
                date: date,
                sum: sum,
                categoryId: 1,
                categoryName: "",
                categoryColor: .black)
    }
    
    static func mock() -> Payment {
        Payment(id: 1,
                description: "На булочки",
                date: .now,
                sum: 200,
                categoryId: 1,
                categoryName: "Еда",
                categoryColor: .init(hex: "E0C279"))
    }
    
    static func mock2() -> Payment {
        Payment(id: 2,
                description: "",
                date: .now,
                sum: 800,
                categoryId: 1,
                categoryName: "Еда",
                categoryColor: .init(hex: "E0C279"))
    }
    
    static func mock3() -> Payment {
        Payment(id: 3,
                description: "ЖКХ",
                date: .now,
                sum: 2200,
                categoryId: 2,
                categoryName: "Жилье",
                categoryColor: .init(hex: "E0B075"))
    }
}
