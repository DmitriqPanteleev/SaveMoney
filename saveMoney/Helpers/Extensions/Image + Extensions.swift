//
//  Image + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI

extension Image {
    init(_ image: AppImage) {
        self.init(image.rawValue)
    }
    
    func defaultAppIcon(height: CGFloat = 20, color: Color = .black) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(height: height)
            .foregroundColor(color)
    }
}
