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
    private weak var router: AddPaymentRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    init(isEditing: Bool,
         payment: Payment? = nil,
         categoryApiService: AllCategoryApiProtocol,
         apiService: PaymentAddEditApiProtocol,
         router: AddPaymentRouter?) {
        self.apiService = apiService
        self.categoryApiService = categoryApiService
        self.router = router
        
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
        bindOnAppear()
        bindDescription()
        bindSum()
        bindDateChange()
        bindCategoryChange()
        bindSaveTap()
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
        
        input.onTextFieldTap
            .handleEvents(receiveOutput: { [weak self] in
                guard let self = self else { return }
                if self.output.isShowingDatePicker || output.isShowingAppKeyboard {
                    self.output.isShowingDatePicker = false
                    self.output.isShowingAppKeyboard = false
                } else {
                    self.output.isShowingDatePicker = false
                    self.output.isShowingAppKeyboard = true
                }
            })
            .sink { [weak self] in
                if self?.output.description == "Введите описание" {
                    self?.output.description = ""
                }
            }
            .store(in: &cancellable)
        
        input.onDescriptionChange
            .sink { [weak self] text in
                self?.output.description = text
            }
            .store(in: &cancellable)
    }
    
    func bindDateChange() {
        input.onDateChange
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.output.isShowingAppKeyboard = false
            })
            .delay(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] date in
                self?.output.isShowingDatePicker = true
            }
            .store(in: &cancellable)
    }
    
    func bindSum() {
        input.onSumChange
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.output.isShowingDatePicker = false
            })
            .delay(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.output.sum += text
                self?.output.isShowingAppKeyboard = true
            }
            .store(in: &cancellable)
    }
    
    func bindCategoryChange() {
        input.onCategoryChange
            .sink { [weak self] id in
                self?.output.categoryId = id
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
                print(error)
                self?.output.screenState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellable)
        
        request
            .values()
            .sink { [weak self] in
                self?.router?.pop()
            }
            .store(in: &cancellable)
    }
}

extension AddPaymentViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        
        let onDescriptionChange = PassthroughSubject<String, Never>()
        let onDescriptionInfo = PassthroughSubject<Void, Never>()
        let onTextFieldTap = PassthroughSubject<Void, Never>()
        
        let onTabSectionChange = PassthroughSubject<TabSection, Never>()
        
        let onSumChange = PassthroughSubject<String, Never>()
        let onDateChange = PassthroughSubject<Date, Never>()
        let onCategoryChange = PassthroughSubject<Int, Never>()
        
        let onSaveButtonTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .content
        
        var description: String = "Введите описание"
        var date: Date = .now
        var sum = "1000"
        var categoryId = 0
        
        var paymentId: Int?
        var isEditing: Bool
        
        var isShowingAppKeyboard = true
        var isShowingDatePicker = false
        
        var categories: [Category] = [.mock(), .mock2(), .mock3(), .mock4()]
    }
}
