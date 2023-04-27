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
                 colorString: "E0C279",
                 isCustom: false)
    }
    
    static func mock2() -> Category {
        Category(id: 2,
                 name: "Жилье",
                 colorString: "E0B075",
                 isCustom: false)
    }
    
    static func mock3() -> Category {
        Category(id: 3,
                 name: "Связь и интернет",
                 colorString: "615434",
                 isCustom: false)
    }
    
    static func mock4() -> Category {
        Category(id: 4,
                 name: "Автомобиль",
                 colorString: "615D51",
                 isCustom: true)
    }
}
