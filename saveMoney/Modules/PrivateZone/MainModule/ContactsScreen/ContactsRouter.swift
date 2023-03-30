//
//  ContactsRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation

protocol ContactsRouter: AnyObject {
    func pushToAddContact()
}

extension ContactsCoordinator: ContactsRouter {
    func pushToAddContact() {
        self.route(to: \.deviceContacts)
    }
}
