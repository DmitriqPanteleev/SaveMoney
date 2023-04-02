//
//  Category.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import Foundation

struct Category: Identifiable {
    let id: Int
    let name: String
    let isCustom: Bool
    
    static func mock() -> Category {
        Category(id: 1,
                 name: "Еда",
                 isCustom: false)
    }
    
    static func mock2() -> Category {
        Category(id: 2,
                 name: "Жилье",
                 isCustom: false)
    }
    
    static func mock3() -> Category {
        Category(id: 3,
                 name: "Связь и интернет",
                 isCustom: false)
    }
    
    static func mock4() -> Category {
        Category(id: 4,
                 name: "Автомобиль",
                 isCustom: true)
    }
}
