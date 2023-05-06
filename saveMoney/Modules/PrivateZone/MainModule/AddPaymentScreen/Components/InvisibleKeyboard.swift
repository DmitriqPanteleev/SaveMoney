//
//  InvisibleKeyboard.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 06.05.2023.
//

import SwiftUI
import Combine

struct InvisibleKeyboard: View {
    
    @Binding var text: String
    @FocusState var state: Bool
    let onChangeText: PassthroughSubject<String, Never>
    let onFieldTap: PassthroughSubject<Void, Never>
    
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(.plain)
            .lineLimit(1)
            .foregroundColor(.clear)
            .tint(.clear)
            .onChange(of: text, perform: sendText)
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .onTapGesture {
                onFieldTap.send()
                withAnimation {
                    state.toggle()
                }
            }
            .onSubmit {
                onFieldTap.send()
                withAnimation {
                    state = false
                }
            }
    }
}

private extension InvisibleKeyboard {
    func sendText(_ value: String) {
        onChangeText.send(value)
    }
}

#if DEBUG
struct InvisibleKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        InvisibleKeyboard(text: .constant("wrgjpiferoignjreopgerngoiergnreogneropgrenognerogergorengoinergouerqnugopreqpguoejgqprgjiqeg"), onChangeText: PassthroughSubject<String, Never>(), onFieldTap: PassthroughSubject<Void, Never>())
    }
}
#endif
