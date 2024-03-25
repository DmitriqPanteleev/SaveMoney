//
//  PersonalAnalyticViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation
import Combine
import CombineExt

final class PersonalAnalyticViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: AnalizeApiProtocol
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: AnalizeApiProtocol) {
        self.apiService = apiService
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension PersonalAnalyticViewModel {
    func bind() {
        bindOnAppear()
        bindIntervalTap()
        
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
    
    func bindIntervalTap() {
        input.onIntervalTap
            .map { $0.countDateFrom }
            .sink { [weak self] dateFrom in
                self?.output.dateFrom = dateFrom
                self?.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
}

extension PersonalAnalyticViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onIntervalTap = PassthroughSubject<AnalitycInterval, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .processing
        
        var categories: [AnalizeCategory] = []
        var payments: [Payment] = []
        var interval: AnalitycInterval = .day
        
        var dateFrom = Date.now.toString
        var dateTo = Date.now.toString
    }
}
