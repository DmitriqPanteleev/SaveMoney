//
//  LoadingView.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 16.02.2023.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isAnimated = false
    let isLittle: Bool
    
    init(isLittle: Bool = false) {
        self.isLittle = isLittle
    }
    
    var body: some View {
        content
    }
}

private extension LoadingView {
    var content: some View {
        HStack {
            ForEach(0..<3) { index in
                Circle()
                    .fill(ColorsPalette.shared.beige)
                    .frame(width: isLittle ? 10 : 20,
                           height: isLittle ? 10 : 20)
                    .scaleEffect(isAnimated ? 1.0 : 0.5)
                    .animation(.easeInOut(duration: 0.3)
                        .repeatForever()
                        .delay(Double(index) / 5))
            }
        }
        .onAppear {
            isAnimated = true
        }
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
