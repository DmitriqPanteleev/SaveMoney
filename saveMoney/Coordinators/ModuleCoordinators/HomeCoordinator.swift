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
    
    init(categoryApiService: AllCategoryApiProtocol) {
        self.categoryApiService = categoryApiService
    }
    
#if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
#endif
}

extension HomeCoordinator {
    @ViewBuilder func makeStart() -> some View {
        let viewModel = MainViewModel(router: self)
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeAddPayment() -> some View {
        let viewModel = AddPaymentViewModel(isEditing: false,
                                            categoryApiService: categoryApiService,
                                            apiService: paymentApiService)
        AddPaymentView(viewModel: viewModel)
    }
}
