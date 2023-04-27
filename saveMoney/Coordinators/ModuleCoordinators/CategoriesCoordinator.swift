//
//  CategoriesCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Stinsen

final class CategoriesCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \CategoriesCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var addCategory = makeAddCategory
    
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

extension CategoriesCoordinator {
    @ViewBuilder func makeStart() -> some View {
        let viewModel = CategoriesViewModel(apiService: categoryApiService,
                                            router: self)
        CategoriesView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeAddCategory() -> some View {
        AddCategoryView()
    }
}
