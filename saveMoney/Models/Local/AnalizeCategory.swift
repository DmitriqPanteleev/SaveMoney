//
//  AnalizeCategory.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.03.2023.
//

import SwiftUI

struct AnalizeCategory: Identifiable, Comparable {
    let id: Int
    let name: String
    let sum: Int
    let colorString: String
    // дата на моей стороне
    
    var formattedSum: String {
        "\(sum) ₽"
    }
    
    var color: Color {
        .init(hex: colorString)
    }
    
    static func < (lhs: AnalizeCategory, rhs: AnalizeCategory) -> Bool {
        lhs.sum < lhs.sum
    }
    
    static func > (lhs: AnalizeCategory, rhs: AnalizeCategory) -> Bool {
        lhs.sum > lhs.sum
    }
    
    static func mock() -> AnalizeCategory {
        AnalizeCategory(id: 1,
                        name: "Еда",
                        sum: 10000,
                        colorString: "38243D")
    }
    
    static func mock2() -> AnalizeCategory {
        AnalizeCategory(id: 2,
                        name: "Жилье",
                        sum: 20000,
                        colorString: "AD70BD")
    }
    
    static func mock3() -> AnalizeCategory {
        AnalizeCategory(id: 3,
                        name: "Связь и интернет",
                        sum: 2000,
                        colorString: "C3B2C8")
    }
    
    static func mock4() -> AnalizeCategory {
        AnalizeCategory(id: 4,
                        name: "Автомобиль",
                        sum: 7000,
                        colorString: "7E518A")
    }
}
