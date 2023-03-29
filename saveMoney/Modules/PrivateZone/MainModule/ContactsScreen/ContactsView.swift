//
//  ContactsView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI
import Combine

struct ContactsView: View {
    
    @StateObject var viewModel: ContactsViewModel
    
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
            ForEach(viewModel.output.contacts, content: contactCell)
            AddContactButton(actionPublisher: viewModel.input.onAddButtonTap)
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
        ContactsView(viewModel: ContactsViewModel(onUpdateTrigger: PassthroughSubject<Void, Never>(), router: nil))
    }
}
#endif
