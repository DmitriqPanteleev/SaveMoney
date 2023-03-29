//
//  DeviceContactCellView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI
import Combine

struct DeviceContactCellView: View {
    
    let model: Contact
    let actionPublisher: PassthroughSubject<Contact, Never>
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.nickname)
                Text(model.phoneNumber)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(actionPublisher: actionPublisher,
                   sendableModel: model) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
            }
                   .tint(.appGreen)
        }
        .padding(.horizontal)
    }
}

struct DeviceContactCellView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceContactCellView(model: .mock(), actionPublisher: PassthroughSubject<Contact, Never>())
    }
}
