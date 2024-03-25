//
//  Int + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import Foundation

extension Int {
    var separatedNumber: String {
        let number = self as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: number) ?? ""
    }
}
