//
//  Colors.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation

import SwiftUI

extension Color {
    enum Name: String {
        case appGreen
        
        var path: String { rawValue }
    }
}

extension Color {
    init(_ name: Color.Name) {
        self.init(name.path)
    }
    
    static let appGreen = Color(.appGreen)
}

extension UIColor {
    convenience init(named name: Color.Name) {
        self.init(named: name.path)!
    }
}
