//
//  PhoneTextField.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import SwiftUI
import Combine

fileprivate enum Masks {
    static let phoneMask = "(XXX) XXX XX XX"
    static let countryPhoneCode = "+7"
}

struct PhoneTextField: View {
    
    @Binding var number: String
    let state: TextFieldState
    let placeholder: Strings
    let onChangePhone: PassthroughSubject<String, Never>
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            countryPhoneCode
            separator
            textField
            clearButton
        }
        .padding(.horizontal, 16)
        .background(ColorsPalette.shared.lightGray.opacity(0.1))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(state.borderColor))
        .animation(.easeIn, value: state.borderColor)
    }
}

private extension PhoneTextField {
    
    var countryPhoneCode: some View {
        Text(Masks.countryPhoneCode)
            .foregroundColor(state == .success ? .black : .gray)
            .padding(.trailing, 9)
    }
    
    var separator: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(state.borderColor)
            .frame(width: 2, height: 30, alignment: .center)
            .padding(.trailing, 12)
    }
    
    var textField: some View {
        TextField(Strings.phonePlaceholder.rawValue.localized(.russian),
                  text: $number)
        .frame(height: 45, alignment: .leading)
        .onChange(of: number, perform: onNumberChange)
        .onChange(of: number, perform: formatNumber)
    }
    
    @ViewBuilder var clearButton: some View {
        if !number.isEmpty {
            Button(action: clearTextField) {
                Image(systemName: "xmark")
                    .defaultAppIcon(height: 10,
                                    color: state.iconColor)
            }
        }
    }
}

private extension PhoneTextField {
    
    func clearTextField() {
        number = ""
    }
    
    func onNumberChange(_ value: String) {
        onChangePhone.send(value)
    }
    
    func formatNumber(_ value: String) {
        number = format(value.toCorrectNumber())
    }
    
    func format(_ number: String) -> String {
        let numbers = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in Masks.phoneMask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

#if DEBUG
struct PhoneTextField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneTextField(number: .constant(""),
                       state: .editing,
                       placeholder: .phonePlaceholder,
                       onChangePhone: PassthroughSubject<String, Never>())
    }
}
#endif

