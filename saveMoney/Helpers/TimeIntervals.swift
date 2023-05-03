//
//  TimeIntervals.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

extension AnalitycInterval {
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
}
