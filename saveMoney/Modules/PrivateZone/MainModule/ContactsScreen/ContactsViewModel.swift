//
//  ContactsViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation
import Combine

final class ContactsViewModel: ObservableObject {
    
    // MARK: - Services
    private weak var router: ContactsRouter?
    private let onUpdateTrigger: PassthroughSubject<Void, Never>
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(onUpdateTrigger: PassthroughSubject<Void, Never>,
         router: ContactsRouter?) {
        self.onUpdateTrigger = onUpdateTrigger
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension ContactsViewModel {
    func bind() {
        bindOnAppear()
        bindOnAddButtonTap()
    }
    
    func bindOnAppear() {
        input.onAppear.combineLatest(onUpdateTrigger)
            .sink { [weak self] _ in
                self?.output.contacts = [.mock(), .mock2()]
            }
            .store(in: &cancellable)
    }
    
    func bindOnAddButtonTap() {
        input.onAddButtonTap
            .sink { [weak self] in
                self?.router?.pushToAddContact()
            }
            .store(in: &cancellable)
    }
}

extension ContactsViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onAddButtonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var contacts: [Contact] = []
    }
}
