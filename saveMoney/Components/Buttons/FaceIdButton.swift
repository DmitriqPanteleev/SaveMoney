//
//  FaceIdButton.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Combine

struct FaceIdButton: View {
    
    let actionPublisher: PassthroughSubject<Void, Never>
    
    var body: some View {
        Button(action: onActionSend) {
            Image(systemName: "faceid")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(ColorsPalette.shared.gray)
        }
    }
}

private extension FaceIdButton {
    func onActionSend() {
        actionPublisher.send()
    }
}

#if DEBUG
struct FaceIdButton_Previews: PreviewProvider {
    static var previews: some View {
        FaceIdButton(actionPublisher: PassthroughSubject<Void, Never>())
    }
}
#endif
