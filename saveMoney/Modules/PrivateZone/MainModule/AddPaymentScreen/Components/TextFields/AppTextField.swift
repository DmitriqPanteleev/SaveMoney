//
//  DescriptionTextField.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import SwiftUI
import Combine

enum AppTextFieldStyle {
    case description
    case sum
    
    var image: String {
        switch self {
        case .description:
            return "text.bubble"
        case .sum:
            return "dollarsign"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .sum:
            return .numberPad
        default:
            return .default
        }
    }
}

struct AppTextField: View {
    
    let placeholder: String
    @Binding var text: String
    let style: AppTextFieldStyle
    let onChangeText: PassthroughSubject<String, Never>
    
    var body: some View {
        HStack(spacing: 8) {
            iconView
                .padding(.leading, 10)
            TextField(placeholder, text: $text)
                .onChange(of: text, perform: onChangeTextSend)
            
            clearButton
                .padding(.trailing)
        }
        .frame(height: 40)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .animation(.default, value: text.isEmpty)
    }
}

private extension AppTextField {
    var iconView: some View {
        Image(systemName: style.image)
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .frame(width: 14, height: 14)
    }
    
    @ViewBuilder var clearButton: some View {
        if !text.isEmpty {
            Button(action: clearText) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

private extension AppTextField {
    func clearText() {
        text = ""
    }
    
    func onChangeTextSend(_ value: String) {
        onChangeText.send(value)
    }
}

#if DEBUG
struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(placeholder: "Введите что-то",
                     text: .constant("ed"),
                     style: .sum,
                     onChangeText: PassthroughSubject<String, Never>())
        .padding(.horizontal)
    }
}
#endif
