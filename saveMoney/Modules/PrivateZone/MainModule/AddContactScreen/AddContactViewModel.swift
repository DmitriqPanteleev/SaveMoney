//
//  AddContactViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation
import Combine
import CombineExt

final class AddContactViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let contactsManager: ContactsManager
    private let onBackTrigger: PassthroughSubject<Void, Never>
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(contactsManager: ContactsManager,
         onBackTrigger: PassthroughSubject<Void, Never>) {
        self.contactsManager = contactsManager
        self.onBackTrigger = onBackTrigger
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension AddContactViewModel {
    func bind() {
        bindOnAppear()
    }
    
    func bindOnAppear() {
        let appearTrigger = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                // TODO: change state
            })
            .map { [unowned self] in
                Future {
                    try await self.contactsManager.fetchContacts()
                }
                .materialize()
            }
            .switchToLatest()
            .share()
            .receive(on: DispatchQueue.main)
            
        appearTrigger
            .failures()
            .sink { [weak self] error in
                print(error)
            }
            .store(in: &cancellable)
        
        appearTrigger
            .values()
            .sink { [weak self] contacts in
                self?.output.contacts = contacts
            }
            .store(in: &cancellable)
    }
}

extension AddContactViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onContactTap = PassthroughSubject<Contact, Never>()
    }
    
    struct Output {
        var contacts: [Contact] = []
    }
}
