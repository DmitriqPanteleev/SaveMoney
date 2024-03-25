//
//  RegularButton.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI
import Combine

struct RegularButton: View {
    
    let title: Strings
    let onTapAction: PassthroughSubject<Void, Never>
    
    var body: some View {
        Button(actionPublisher: onTapAction) {
            Text(title)
                .frame(width: UIScreen.main.bounds.width - 32,
                       height: 44)
                .background(ColorsPalette.shared.beige)
                .cornerRadius(8)
        }
        .tint(.white)
    }
}

struct SigningButton: View {
    
    let title: Strings
    let sendableModel: SigningState
    let onTapAction: PassthroughSubject<SigningState, Never>
    
    var body: some View {
        Button(actionPublisher: onTapAction,
               sendableModel: sendableModel) {
            Text(title)
                .frame(width: UIScreen.main.bounds.width - 32,
                       height: 44)
                .background(ColorsPalette.shared.beige)
                .cornerRadius(8)
        }
        .tint(.white)
    }
}

#if DEBUG
struct RegularButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularButton(title: .retry,
                      onTapAction: PassthroughSubject<Void, Never>())
    }
}
#endif
