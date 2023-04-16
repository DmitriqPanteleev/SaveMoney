//
//  RegularButton.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI
import Combine

struct RegularButton: View {
    
    let onTapAction: PassthroughSubject<Void, Never>
    
    var body: some View {
        Button(actionPublisher: onTapAction) {
            Text(.retry)
                .frame(width: UIScreen.main.bounds.width - 32,
                       height: 44)
                .background(ColorsPalette.shared.beige)
                .cornerRadius(8)
        }
        .tint(.white)
    }
}

struct RegularButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularButton(onTapAction: PassthroughSubject<Void, Never>())
    }
}
