//
//  KeyboardControlView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 05.04.2023.
//

import SwiftUI
import Combine

struct KeyboardControlView: View {
    
    @Binding var isShowing: Bool
    @Binding var sum: String
    
    let onTypeChange: PassthroughSubject<TabSection, Never>
    let onSumChange: PassthroughSubject<String, Never>
    let onDoneTap: PassthroughSubject<Void, Never>
    
    
    var body: some View {
        content
            .transition(.move(edge: .bottom))
            .animation(.default, value: isShowing)
    }
}

private extension KeyboardControlView {
    
    @ViewBuilder var content: some View {
        if isShowing {
            VStack(spacing: 16) {
                Spacer()
                HStack(spacing: 10) {
                    textFieldView
                    doneButton
                }
                paymentTypeControlView
                appKeyboardView
            }
            .padding(.bottom)
            .padding(.horizontal, 24)
        }
    }
    
    var doneButton: some View {
        Button(actionPublisher: onDoneTap) {
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .padding(10)
                .background(ColorsPalette.shared.lightOrange)
                .cornerRadius(30)
        }
        .tint(Color.white)
    }
    
    var textFieldView: some View {
        Text(sum.isEmpty ? "0" : sum)
            .foregroundColor(.appGray)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.04))
            .cornerRadius(100)
    }
    
    var paymentTypeControlView: some View {
        TransactionTabView(onChangeType: onTypeChange)
    }
    
    var appKeyboardView: some View {
        HStack {
            AppKeyboardView(text: $sum,
                            onNumberTap: onSumChange)
        }
    }
}

private extension KeyboardControlView {
    
}

#if DEBUG
struct KeyboardControlView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardControlView(isShowing: .constant(true),
                            sum: .constant(""),
                            onTypeChange: PassthroughSubject<TabSection, Never>(),
                            onSumChange: PassthroughSubject<String, Never>(),
                            onDoneTap: PassthroughSubject<Void, Never>())
    }
}
#endif
