//
//  MaiinViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 30.03.2023.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    // MARK: - Services
    private weak var router: MainRouter?
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(router: MainRouter?) {
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
        let onChangeInterval = PassthroughSubject<AnalitycInterval, Never>()
        let onChangeTab = PassthroughSubject<TabSection, Never>()
        let onCategoryTap = PassthroughSubject<AnalizeCategory, Never>()
        let onAddCategoryTap = PassthroughSubject<Void, Never>()
        let onPaymentTap = PassthroughSubject<Payment, Never>()
        let onAddPaymentTap = PassthroughSubject<Void, Never>()
        let onAnalyticsTap = PassthroughSubject<Void, Never>()
        let onSettingsTap = PassthroughSubject<Void, Never>()
        let onExitTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var profile: User = .mock()
        var categories: [AnalizeCategory] = [.mock(), .mock2(), .mock3(), .mock4()]
        var payments: [Payment] = [.mock(), .mock2(), .mock3()]
        
        var tabSection: TabSection = .outcomes
        var interval: AnalitycInterval = .day
        var date: Date = .now
    }
}

enum AnalitycInterval {    
    case day
    case week
    case month
    case year
    
    static var allCases: [AnalitycInterval] {
        [.day, .week, .month, .year]
    }
}
