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
    @Route(.modal) var deviceContacts = makeAddContact
    
    private let contactsManager = DIContainer.shared.container.resolve(ContactsManager.self)!
    private let onUpdateTrigger = PassthroughSubject<Void, Never>() // TODO: инскапуслируем?
    
#if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
#endif
}

extension ContactsCoordinator {
    @ViewBuilder func makeContactBook() -> some View {
        let viewModel = ContactsViewModel(onUpdateTrigger: onUpdateTrigger, router: self)
        ContactsView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeAddContact() -> some View {
        let viewModel = AddContactViewModel(contactsManager: contactsManager,
                                            onBackTrigger: onUpdateTrigger)
        AddContactView(viewModel: viewModel)
    }
}
