//
//  Category.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    let id: Int
    let name: String
    let colorString: String
    let isCustom: Bool
    
    var color: Color {
        .init(hex: colorString)
    }
    
    static func mock() -> Category {
        Category(id: 1,
                 name: "Еда",
                 colorString: "38243D",
                 isCustom: false)
    }
    
    static func mock2() -> Category {
        Category(id: 2,
                 name: "Жилье",
                 colorString: "AD70BD",
                 isCustom: false)
    }
    
    static func mock3() -> Category {
        Category(id: 3,
                 name: "Связь и интернет",
                 colorString: "C3B2C8",
                 isCustom: false)
    }
    
    static func mock4() -> Category {
        Category(id: 4,
                 name: "Автомобиль",
                 colorString: "7E518A",
                 isCustom: true)
    }
}
