//
//  AuthTextField.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 22.02.2023.
//

import SwiftUI
import Combine

enum TextFieldState {
    case error
    case editing
    case success
    
    var backgroundColor: Color {
        self == .error ? .red : ColorsPalette.shared.lightGray
    }
    
    var borderColor: Color {
        switch self {
        case .error:
            return .red
        case .editing:
            return ColorsPalette.shared.lightGray
        case .success:
            return ColorsPalette.shared.lightOrange
        }
    }
    
    var iconColor: Color {
        switch self {
        case .error:
            return .red
        case .editing:
            return .gray.opacity(0.5)
        case .success:
            return ColorsPalette.shared.lightOrange
        }
    }
    
    var errorDescription: String {
        "Неправильный email"
    }
}

struct EmailTextField: View {
    
    @Binding var text: String
    let state: TextFieldState
    
    let placeholder: Strings
    let onChangeText: PassthroughSubject<String, Never>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack(spacing: 8) {
                leadingIcon
                textField
                trailingButton
            }
            .padding(.horizontal, 12)
            .frame(height: 45)
            .background(state.backgroundColor.opacity(0.1))
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12).stroke(state.borderColor, lineWidth: 1)
            }
            .animation(.easeIn, value: state.borderColor)
            
            description
        }
    }
}

private extension EmailTextField {
    
    var leadingIcon: some View {
        Image(systemName: "envelope")
            .defaultAppIcon(height: 16,
                            color: state.iconColor)
            .frame(width: 30)
            .animation(.easeIn, value: state.iconColor)
    }
    
    var textField: some View {
        TextField(placeholder.rawValue.localized(.russian),
                  text: $text)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .onChange(of: text, perform: onChangeTextSend)
    }
    
    @ViewBuilder var trailingButton: some View {
        ZStack {
            successIcon
            clearButton
        }
        .animation(.easeIn, value: state)
    }
    
    @ViewBuilder var successIcon: some View {
        if state == .success {
            Image(systemName: "checkmark")
                .defaultAppIcon(height: 10,
                                color: state.iconColor)
        }
    }
    
    @ViewBuilder var clearButton: some View {
        if !text.isEmpty && !(state == .success) {
            Button(action: clearTextField) {
                Image(systemName: "xmark")
                    .defaultAppIcon(height: 10,
                                    color: state.iconColor)
            }
        }
    }
    
    @ViewBuilder var description: some View {
        if state == .error {
            Text(state.errorDescription)
                .font(.callout)
                .foregroundColor(.red)
        }
    }
}

private extension EmailTextField {
    func clearTextField() {
        withAnimation() {
            text = ""
        }
    }
    
    func onChangeTextSend(_ text: String) {
        onChangeText.send(text)
    }
}

#if DEBUG
struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField(text: .constant("ed"),
                       state: .success,
                       placeholder: .emailPlaceholder,
                       onChangeText: PassthroughSubject<String, Never>())
    }
}
#endif
