//
//  Array + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

extension Array where Element == String {
    func unique() -> [Element] {
        let tmp = Set(self)
        return Array(tmp)
    }
}
