//
//  ContactsView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI
import Combine

struct ContactsView: View {
    
    let models: [Contact]
    
    var body: some View {
        content()
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}

private extension ContactsView {
    func content() -> some View {
        contactList
    }
    
    var contactList: some View {
        ScrollView {
            ForEach(models, content: contactCell)
            AddContactButton(actionPublisher: PassthroughSubject<Void, Never>())
        }
    }
    
    func contactCell(_ model: Contact) -> some View {
        ContactCellView(model: model)
    }
}

private extension ContactsView {
    
}

#if DEBUG
struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(models: [
            .mock(),
            .mock2(),
            .mock3()
        ])
    }
}
#endif
