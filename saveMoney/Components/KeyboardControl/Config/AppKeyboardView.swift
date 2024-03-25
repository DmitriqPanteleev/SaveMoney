//
//  AppKeyboardView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 05.04.2023.
//

import SwiftUI
import Combine

enum AppKeyboardSizes {
    static let item = GridItem(.fixed(30),
                        spacing: 60,
                        alignment: .center)
    static let columns = Array(repeating: item, count: 3)
}

enum OperationTypes: String, Hashable {
    case plus
    case minus
    case divide
    case multiply
    
    static var allCases: [OperationTypes] {
        return [.plus, .minus, .divide, .multiply]
    }
    
    var operation: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .divide:
            return "/"
        case .multiply:
            return "*"
        }
    }
}

struct AppKeyboardView: View {
    @Binding var text: String
    let onNumberTap: PassthroughSubject<String, Never>
    
    var body: some View {
        VStack(spacing: 20) {
            keyboardView
        }
    }
}

private extension AppKeyboardView {
    var keyboardView: some View {
        HStack(spacing: 60) {
            LazyVGrid(columns: AppKeyboardSizes.columns,
                      spacing: 32,
                      pinnedViews: []) {
                ForEach(1..<10, content: keyboardCell)
                Spacer()
                keyboardCell(0)
                eraseButtonView
            }
            operationsBlockView
        }
    }
    
    func keyboardCell(_ value: Int) -> some View {
        Button(actionPublisher: onNumberTap,
               sendableModel: String(value)) {
            Text(String(value))
                .foregroundColor(.appGray)
                .font(.system(size: 20))
        }
    }
    
    var eraseButtonView: some View {
        Button(action: eraseLastSymbol) {
            Image(systemName: "delete.left")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .tint(Color.appGray)
    }
    
    var operationsBlockView: some View {
        VStack(spacing: 32) {
            ForEach(OperationTypes.allCases, id: \.self) { item in
                Button(action: {}) {
                    Image(systemName: item.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .padding(6)
                }
                .tint(Color.appGray)
            }
        }
    }
}

private extension AppKeyboardView {
    func eraseLastSymbol() {
        if !text.isEmpty {
            text.removeLast(1)
        }
    }
}

#if DEBUG
struct AppKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        AppKeyboardView(text: .constant("ed"),
                        onNumberTap: PassthroughSubject<String, Never>())
    }
}
#endif
