//
//  PinCodeInputStatusView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI

struct PinCodeInputStatusView: View {
    
    let inputCount: Int
    
    var body: some View {
        HStack {
            ForEach(1..<5) { number in
                number <= inputCount ? AnyView(enteredCell) : AnyView(emptyCell)
            }
        }
    }
}

private extension PinCodeInputStatusView {
    var enteredCell: some View {
        Circle()
            .foregroundColor(ColorsPalette.shared.beige)
            .frame(width: 20)
    }
    
    var emptyCell: some View {
        Circle()
            .foregroundColor(ColorsPalette.shared.lightGray)
            .frame(width: 20)
    }
}

#if DEBUG
struct PinCodeInputStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeInputStatusView(inputCount: 2)
    }
}
#endif
