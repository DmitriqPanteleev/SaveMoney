//
//  MaiinViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 30.03.2023.
//

import Foundation
import Combine
import CombineExt

final class MainViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: AnalizeApiProtocol
    private weak var router: MainRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: AnalizeApiProtocol, router: MainRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension MainViewModel {
    func bind() {
        bindOnAppear()
        bindAddPaymentTap()
    }
    
    func bindOnAppear() {
        input.onAppear
            .map { [unowned self] in
                Future {
                    await self.getAll()
                }
            }
            .switchToLatest()
            .replaceError(with: ())
            .sink {}
            .store(in: &cancellable)
    }
    
    @MainActor
    func getAll() async {
        Task {
            self.output.screenState = .processing
            
            async let categories = self.apiService.getAnalizeCategories(dateFrom: self.output.dateFrom,
                                                                        dateTo: self.output.dateTo)
            
            async let payments = self.apiService.getAllPaymens(from: self.output.dateFrom,
                                                               to: self.output.dateTo)
            
            do {
                self.output.categories = try await categories
                self.output.payments = try await payments
                self.output.screenState = .content
            } catch {
                self.output.screenState = .error(message: nil)
            }
        }
    }
    
    func bindAddPaymentTap() {
        input.onAddPaymentTap
            .sink { [weak self] in
                self?.router?.pushToAddPayment()
            }
            .store(in: &cancellable)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
//        let onChangeTab = PassthroughSubject<TabSection, Never>()
        let onCategoryTap = PassthroughSubject<Void, Never>()
//        let onAddCategoryTap = PassthroughSubject<Void, Never>()
        let onPaymentTap = PassthroughSubject<Payment, Never>()
        let onAddPaymentTap = PassthroughSubject<Void, Never>()
        let onQuestionTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .processing
        var categories: [AnalizeCategory] = [.mock(), .mock2(), .mock3(), .mock4()]
        var payments: [Payment] = [.mock(), .mock2(), .mock3()]
        
        var dateFrom = Date.startOfMonth
        var dateTo = Date.endOfMonth
    }
}
