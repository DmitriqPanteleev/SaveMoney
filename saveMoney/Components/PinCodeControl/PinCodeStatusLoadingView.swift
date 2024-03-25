//
//  PinCodeStatusLoadingView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI

struct PinCodeStatusLoadingView: View {
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        content
    }
}

private extension PinCodeStatusLoadingView {
    var content: some View {
        HStack {
            ForEach(0..<4) { index in
                Circle()
                    .fill(ColorsPalette.shared.beige)
                    .frame(width: 20,
                           height: 20)
                    .frame(width: 20,
                           height: 20)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 0.3)
                        .repeatForever()
                        .delay(Double(index) / 8), value: scale)
            }
        }
        .onAppear {
            scale = 0.5
        }
    }
}

#if DEBUG
struct PinCodeStatusLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeStatusLoadingView()
    }
}
#endif

