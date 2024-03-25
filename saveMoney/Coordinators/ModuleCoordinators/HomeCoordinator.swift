//
//  HomeCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Stinsen
import Combine

final class HomeCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \HomeCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var addPayment = makeAddPayment
    
    private let paymentApiService = DIContainer.shared.container.resolve(PaymentApiService.self)!
    private let categoryApiService: AllCategoryApiProtocol
    private let analyticApiService: AnalizeApiProtocol
    
    init(categoryApiService: AllCategoryApiProtocol,
         analyticApiService: AnalizeApiProtocol) {
        self.categoryApiService = categoryApiService
        self.analyticApiService = analyticApiService
    }
    
#if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
#endif
}

extension HomeCoordinator {
    @ViewBuilder func makeStart() -> some View {
        let viewModel = MainViewModel(apiService: analyticApiService, router: self)
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeAddPayment() -> some View {
        let viewModel = AddPaymentViewModel(isEditing: false,
                                            payment: nil,
                                            categoryApiService: categoryApiService,
                                            apiService: paymentApiService,
                                            router: self)
        AddPaymentView(viewModel: viewModel)
    }
}
