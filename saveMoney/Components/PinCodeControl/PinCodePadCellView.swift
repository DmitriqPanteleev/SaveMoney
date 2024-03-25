//
//  PinCodePadCellView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Combine

struct PinCodePadCellView: View {
    
    let number: Int
    let actionPublisher: PassthroughSubject<String, Never>
    
    var body: some View {
        Button(action: { actionPublisherSend(number) },
               label: buttonLabel)
        .tint(.black)
    }
}

private extension PinCodePadCellView {
    func buttonLabel() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(ColorsPalette.shared.lightGray)
                .frame(width: 80, height: 80)
            
            Text(String(number))
                .font(.largeTitle)
        }
    }
}

private extension PinCodePadCellView {
    func actionPublisherSend(_ value: Int) {
        actionPublisher.send(String(value))
    }
}

#if DEBUG
struct PinCodePadCellView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodePadCellView(number: 1,
                           actionPublisher: PassthroughSubject<String, Never>())
    }
}
#endif

