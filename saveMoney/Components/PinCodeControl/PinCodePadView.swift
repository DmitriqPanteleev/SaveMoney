//
//  PinCodePadView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Combine

struct PinCodePadView: View {
    
    let columns = Array(repeating: GridItem(.fixed(96)),
                        count: 3)
    let isFaceId: Bool
    let onCellTapPublisher: PassthroughSubject<String, Never>
    let onEraseTapPublisher: PassthroughSubject<Void, Never>
    let onFaceIdTapPublisher: PassthroughSubject<Void, Never>?
    
    init(isFaceId: Bool = false,
         onCellTapPublisher: PassthroughSubject<String, Never>,
         onEraseTapPublisher: PassthroughSubject<Void, Never>,
         onFaceIdTapPublisher: PassthroughSubject<Void, Never>? = nil) {
        self.isFaceId = isFaceId
        self.onCellTapPublisher = onCellTapPublisher
        self.onEraseTapPublisher = onEraseTapPublisher
        self.onFaceIdTapPublisher = onFaceIdTapPublisher
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(1..<10) { number in
                    PinCodePadCellView(number: number,
                                       actionPublisher: onCellTapPublisher)
                   
                }
                faceIdButton
                PinCodePadCellView(number: 0,
                                   actionPublisher: onCellTapPublisher)
                deleteNumber
            }
        }
    }
}

private extension PinCodePadView {
    var deleteNumber: some View {
        Button(action: onEraseTapSend) {
            Image(systemName: "delete.backward.fill")
                .defaultAppIcon(height: 25,
                                color: .black)
        }
    }
    
    @ViewBuilder var faceIdButton: some View {
        if let publisher = onFaceIdTapPublisher, isFaceId {
            FaceIdButton(actionPublisher: publisher)
        } else {
            Spacer()
        }
    }
}

private extension PinCodePadView {
    func onEraseTapSend() {
        onEraseTapPublisher.send()
    }
}

#if DEBUG
struct PinCodePadView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodePadView(isFaceId: true, onCellTapPublisher: PassthroughSubject<String, Never>(),
                       onEraseTapPublisher: PassthroughSubject<Void, Never>(),
        onFaceIdTapPublisher: PassthroughSubject<Void, Never>())
    }
}
#endif
