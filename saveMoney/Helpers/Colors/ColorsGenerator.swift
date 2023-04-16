//
//  ColorsGenerator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 31.03.2023.
//

import SwiftUI

struct ColorsGenerator {
    
    private init() {}
    
    static func generateColors(for count: Int, shade: Color = .appGreen) -> [Color] {
        var colors: [Color] = []
        
        for index in (1...count) {
            colors.append(shade.opacity(1/Double(index)))
        }
        
        return colors
    }
    
    static func randomColors(for count: Int) -> [Color] {
        var colors: [Color] = []
        
        for _ in (1...count) {
            let color = Color.randomColor
            colors.append(color)
            print(color)
        }
        
        return colors
    }
}
