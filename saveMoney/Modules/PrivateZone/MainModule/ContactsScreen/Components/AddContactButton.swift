//
//  AddContactButton.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI
import Combine

struct AddContactButton: View {
    
    let actionPublisher: PassthroughSubject<Void, Never>

    var body: some View {
        Button(actionPublisher: actionPublisher) {
            HStack(spacing: 10) {
                Image(systemName: "plus")
                Text(.add)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .tint(.gray)
        }
    }
}

struct AddContactButton_Previews: PreviewProvider {
    static var previews: some View {
        AddContactButton(actionPublisher: PassthroughSubject<Void, Never>())
    }
}
