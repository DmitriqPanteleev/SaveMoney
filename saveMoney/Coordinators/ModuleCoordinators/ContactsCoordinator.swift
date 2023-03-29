//
//  ContactsCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI
import Stinsen
import Combine

final class ContactsCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<ContactsCoordinator>(initial: \.contactBook)
    
    @Root var contactBook = makeContactBook
    @Route(.push) var deviceContacts = makeAddContact
    
    private let contactsManager: ContactsManager
    private let onBackTrigger: PassthroughSubject<Void, Never>
    
    init(contactsManager: ContactsManager,
         onBackTrigger: PassthroughSubject<Void, Never>) {
        self.contactsManager = contactsManager
        self.onBackTrigger = onBackTrigger
    }
    
}

extension ContactsCoordinator {
    @ViewBuilder func makeContactBook() -> some View {
        EmptyView()
    }
    
    @ViewBuilder func makeAddContact() -> some View {
        let viewModel = AddContactViewModel(contactsManager: contactsManager,
                                            onBackTrigger: onBackTrigger)
        AddContactView(viewModel: viewModel)
    }
}
