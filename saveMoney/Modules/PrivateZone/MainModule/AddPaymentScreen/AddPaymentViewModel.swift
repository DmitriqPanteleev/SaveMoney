//
//  AddPaymentViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import Foundation
import Combine

final class AddPaymentViewModel: ObservableObject {
    
    // MARK: - Services
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    init(isEditing: Bool,
         payment: Payment? = nil) {
        self.input = Input()
        
        if let model = payment {
            self.output = Output(description: model.description,
                                 date: model.date,
                                 sum: String(model.sum),
                                 categoryId: 0, // TODO: - срочно обсудить
                                 isEditing: true)
        } else {
            self.output = Output(isEditing: false)
        }
        
        bind()
    }
}

private extension AddPaymentViewModel {
    func bind() {
        bindDescription()
        bindSum()
    }
    
    func bindDescription() {
        input.onDescriptionChange
            .handleEvents(receiveOutput: { [weak self] text in
                self?.output.description = text
            })
            .sink { [weak self] text in
                
            }
            .store(in: &cancellable)
    }
    
    func bindSum() {
        input.onSumChange
            .handleEvents(receiveOutput: { [weak self] text in
                
            })
            .sink { [weak self] text in
                self?.output.sum += text
            }
            .store(in: &cancellable)
    }
}

extension AddPaymentViewModel {
    struct Input {
        let onDescriptionChange = PassthroughSubject<String, Never>()
        let onDescriptionInfo = PassthroughSubject<Void, Never>()
        let onTabSectionChange = PassthroughSubject<TabSection, Never>()
        let onSumChange = PassthroughSubject<String, Never>()
        let onDateChange = PassthroughSubject<Date, Never>()
        let onCategoryChange = PassthroughSubject<Int, Never>()
        let onSaveButtonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var description = "Какое-то пиздец насколько длинное описание одной транзакции"
        var date: Date = .now
        var sum = "1000"
        var categoryId = 0
        
        var paymentId: Int?
        var isEditing: Bool
        
//        var dismissKeyboard = false
//        var dismissAppKeyboard = false
        
        var categories: [Category] = [.mock(), .mock2(), .mock3(), .mock4(), .mock(), .mock3(), .mock2(), .mock4()]
    }
}
