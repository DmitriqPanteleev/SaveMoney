//
//  AnalizeCategory.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.03.2023.
//

import SwiftUI

struct AnalizeCategory: Identifiable, Comparable, Hashable {
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
                        colorString: "E0C279")
    }
    
    static func mock2() -> AnalizeCategory {
        AnalizeCategory(id: 2,
                        name: "Жилье",
                        sum: 20000,
                        colorString: "E0B075")
    }
    
    static func mock3() -> AnalizeCategory {
        AnalizeCategory(id: 3,
                        name: "Связь и интернет",
                        sum: 2000,
                        colorString: "615434")
    }
    
    static func mock4() -> AnalizeCategory {
        AnalizeCategory(id: 4,
                        name: "Автомобиль",
                        sum: 7000,
                        colorString: "615D51")
    }
}
