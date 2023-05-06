//
//  Date + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

extension Date {
    func toServerString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: self)
    }
    
    var toString: String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    static var startOfMonth: String {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)!
        print(startOfMonth.toString)
        return startOfMonth.toString
    }
    
    static var endOfMonth: String {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)!
        
        var comps = DateComponents()
        comps.month = 1
        comps.day = -1
        
        let endOfMonth = Calendar.current.date(byAdding: comps, to: startOfMonth)!
        print(endOfMonth.toString)
        return endOfMonth.toString
    }
}
