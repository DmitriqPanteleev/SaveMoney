//
//  AddContactView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI

struct AddContactView: View {
    
    @StateObject var viewModel: AddContactViewModel
    
    var body: some View {
        content()
            .onAppear(perform: onAppearSend)
    }
}

private extension AddContactView {
    func content() -> some View {
        ScrollView {
            ForEach(viewModel.output.contacts, content: contactCell)
        }
    }
    
    func contactCell(_ model: Contact) -> some View {
        DeviceContactCellView(model: model,
                              actionPublisher: viewModel.input.onContactTap)
    }
}

private extension AddContactView {
    func onAppearSend() {
        viewModel.input.onAppear.send()
    }
}

#if DEBUG
import Combine

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(viewModel: AddContactViewModel(contactsManager: ContactsManager(), onBackTrigger: PassthroughSubject<Void, Never>()))
    }
}
#endif
