//
//  ColorsPalette.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI

struct ColorsPalette {
    static let shared = ColorsPalette()
    private init() {}
    
    var gray: Color {
        .init(hex: "58626C")
    }
    
    var beige: Color {
        .init(hex: "DAC8BE")
    }
    
    var lightOrange: Color {
        .init(hex: "ECC1A1")
    }
    
    var lightGray: Color {
        .init(hex: "F5F1EE")
    }
}
