//
//  AnalyticInterval.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.05.2023.
//

import Foundation

enum AnalitycInterval {
    case day
    case week
    case month
    case year
    
    var countDateFrom: String {
        switch self {
        case .day:
            return Date.now.toString
        case .week:
            return (Calendar.current as NSCalendar).date(byAdding: .day, value: -7, to: Date(), options: [])!.toString
        case .month:
            return (Calendar.current as NSCalendar).date(byAdding: .month, value: -1, to: Date(), options: [])!.toString
        case .year:
            return (Calendar.current as NSCalendar).date(byAdding: .year, value: -1, to: Date(), options: [])!.toString
        }
    }
    
    static var allCases: [AnalitycInterval] {
        [.day, .week, .month, .year]
    }
}
