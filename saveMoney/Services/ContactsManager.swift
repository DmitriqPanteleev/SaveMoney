//
//  ContactsManager.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation
import Contacts

final class ContactsManager {
    private let store = CNContactStore()
    
    func fetchContacts() async throws -> [Contact] {
        
        var contacts: [Contact] = []
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: fetchRequest,
                                        usingBlock: { contact, _ in
                let newContact = Contact(nickname: contact.givenName,
                                         phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
                contacts.append(newContact)
            })
            
            return contacts
        } catch {
            throw error // TODO: errors
        }
    }
}
