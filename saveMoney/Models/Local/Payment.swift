//
//  Payment.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import Foundation

struct Payment {
    let id: Int
    let description: String
    let date: Date?
    let sum: Int
    let category: String
    
    var formattedSum: String {
        "\(sum) ₽"
    }
    
    // TODO: - date formatters
    var formattedDate: String {
        ""
    }
    
//    func mock1() -> Payment {
//        Payment(id: 1,
//                description: "Купил телефон",
//                sum: 40000)
//    }
//
//    func mock2() -> Payment {
//        Payment(id: 2,
//                description: "Новый свитер",
//                sum: 3000)
//    }
//
//    func mock3() -> Payment {
//        Payment(id: 3,
//                description: "Продукты",
//                sum: 1500)
//    }
//
//    func mock4() -> Payment {
//        Payment(id: 4,
//                description: "Пекарня",
//                sum: 500)
//    }
//
//    func mock5() -> Payment {
//        Payment(id: 5,
//                description: "Посуда",
//                sum: 4000)
//    }
}
