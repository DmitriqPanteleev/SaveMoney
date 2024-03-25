//
//  PasswordTextField.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import SwiftUI
import Combine

struct PasswordTextField: View {
    
    @Binding var text: String
    @State var isSecure: Bool = true
    let state: TextFieldState
    let placeholder: Strings
    let onChangeText: PassthroughSubject<String, Never>
    
    var body: some View {
        HStack(spacing: 8) {
            leadingIcon
            
            secureTextField
            
            showTextButton
            clearButton
        }
        .padding(.horizontal, 12)
        .frame(height: 45)
        .background(ColorsPalette.shared.lightGray.opacity(0.1))
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12).stroke(state.borderColor, lineWidth: 1)
        }
        .animation(.easeIn, value: state.borderColor)
    }
}

private extension PasswordTextField {
    
    var leadingIcon: some View {
        Image(systemName: "lock.fill")
            .defaultAppIcon(color: state.iconColor)
            .frame(width: 30)
    }
    
    var textField: some View {
        TextField(placeholder.rawValue.localized(.russian),
                  text: $text)
        .onChange(of: text, perform: onChangeTextSend)
    }
    
    @ViewBuilder var secureTextField: some View {
        if isSecure {
            SecureField(placeholder.rawValue.localized(.russian),
                        text: $text)
            .onChange(of: text, perform: onChangeTextSend)
        } else {
            textField
        }
    }
    
    @ViewBuilder var clearButton: some View {
        if !text.isEmpty {
            Button(action: clearTextField) {
                Image(systemName: "xmark.circle")
                    .defaultAppIcon(height: 16, color: state.iconColor)
            }
        }
    }
    
    var showTextButton: some View {
        Button(action: toggleSecure) {
            Image(systemName: isSecure ? "eye" : "eye.slash")
                .defaultAppIcon(height: 14, color: state.iconColor)
        }
    }
}

private extension PasswordTextField {
    func clearTextField() {
        withAnimation() {
            text = ""
        }
    }
    
    func toggleSecure() {
        isSecure.toggle()
    }
    
    func onChangeTextSend(_ text: String) {
        onChangeText.send(text)
    }
}

#if DEBUG
struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(text: .constant("ed"),
                          state: .editing,
                          placeholder: .passwordPlaceholder,
                          onChangeText: PassthroughSubject<String, Never>())
    }
}
#endif

