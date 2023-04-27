//
//  CategoriesViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.04.2023.
//

import Foundation
import Combine
import CombineExt

final class CategoriesViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: AllCategoryApiProtocol
    private weak var router: CategoriesRouter?
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: AllCategoryApiProtocol,
         router: CategoriesRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension CategoriesViewModel {
    func bind() {
        bindOnAppear()
    }
    
    func bindOnAppear() {
        let request = input.onAppear
            .handleEvents(receiveOutput: { [weak self] in
                self?.output.screenState = .processing
            })
            .map { [unowned self] in
                Future {
                    try await self.apiService.getAllCategories()
                }
                .materialize()
            }
            .share()
            .switchToLatest()
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
}

extension CategoriesViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var screenState: LoadableViewState = .processing
        var categories: [Category] = []
    }
}
