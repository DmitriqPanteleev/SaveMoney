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
    private let apiService: PaymentAddEditApiProtocol
    private let categoryApiService: AllCategoryApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    init(isEditing: Bool,
         payment: Payment? = nil,
         categoryApiService: AllCategoryApiProtocol,
         apiService: PaymentAddEditApiProtocol) {
        self.apiService = apiService
        self.categoryApiService = categoryApiService
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
        //bindOnAppear()
        bindDescription()
        bindSum()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .processing
            })
            .map { [unowned self] in
                Future {
                    try await self.categoryApiService.getAllCategories()
                }
                .materialize()
            }
            .switchToLatest()
            .share()
            .receive(on: DispatchQueue.main)
        
        request
            .failures()
            .sink { [weak self] error in
                print(error)
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink { [weak self] in
                self?.output.screenState = .content
                self?.output.categories = $0
            }
            .store(in: &cancellable)
    }
    
    func bindDescription() {
        input.onDescriptionChange
            .sink { [weak self] text in
                self?.output.description = text
            }
            .store(in: &cancellable)
    }
    
    func bindSum() {
        input.onSumChange
            .sink { [weak self] text in
                self?.output.sum += text
            }
            .store(in: &cancellable)
    }
    
    func bindSaveTap() {
        let request = input.onSaveButtonTap
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .processing
            })
            .map { [unowned self] in
                if output.isEditing {
                    return Future {
                        try await self.apiService.editPayment(paymentId: self.output.paymentId!,
                                                              categoryId: self.output.categoryId,
                                                              description: self.output.description,
                                                              date: self.output.date.toServerString(),
                                                              sum: Double(Int(self.output.sum)!))
                    }
                    .materialize()
                } else {
                    return Future {
                        try await self.apiService.addPayment(categoryId: self.output.categoryId,
                                                             description: self.output.description,
                                                             date: self.output.date.toServerString(),
                                                             sum: Double(Int(self.output.sum)!))
                    }
                    .materialize()
                }
            }
            .switchToLatest()
            .share()
            .receive(on: DispatchQueue.main)
        
        request
            .failures()
            .sink { [weak self] error in
                
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink {
                // TODO: route back
            }
            .store(in: &cancellable)
    }
}

extension AddPaymentViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onDescriptionChange = PassthroughSubject<String, Never>()
        let onDescriptionInfo = PassthroughSubject<Void, Never>()
        let onTabSectionChange = PassthroughSubject<TabSection, Never>()
        let onSumChange = PassthroughSubject<String, Never>()
        let onDateChange = PassthroughSubject<Date, Never>()
        let onCategoryChange = PassthroughSubject<Int, Never>()
        let onSaveButtonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .content
        
        var description: String? = "Потратил на еду"
        var date: Date = .now
        var sum = "1000"
        var categoryId = 0
        
        var paymentId: Int?
        var isEditing: Bool
        
        //        var dismissKeyboard = false
        //        var dismissAppKeyboard = false
        
        var categories: [Category] = [.mock(), .mock2(), .mock3(), .mock4()]
    }
}
