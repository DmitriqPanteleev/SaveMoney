//
//  AddCategoryViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.04.2023.
//

import Foundation
import Combine
import CombineExt
import CoreGraphics

final class AddCategoryViewModel: ObservableObject {
    // MARK: - Services
    private let apiService: AddEditCategoryProtocol
    private weak var router: AddCategoryRouter?
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: AddEditCategoryProtocol,
         router: AddCategoryRouter?) {
        self.apiService = apiService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
}

private extension AddCategoryViewModel {
    func bind() {
        bindSaveTap()
        bindName()
        bindColor()
    }
    
    func bindName() {
        input.onChangeName
            .sink { [weak self] text in
                self?.output.name = text
            }
            .store(in: &cancellable)
    }
    
    func bindColor() {
        input.onChangeColor
            .sink { [weak self] color in
                self?.output.color = color
            }
            .store(in: &cancellable)
    }
    
    func bindSaveTap() {
        let request = input.onSaveTap
            .map { [unowned self] in
                Future {
                    try await self.apiService.addCategory(name: self.output.name,
                                                          color: self.output.color.toHex())
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
                self?.router?.back()
            }
            .store(in: &cancellable)
    }
}

extension AddCategoryViewModel {
    struct Input {
        let onChangeName = PassthroughSubject<String, Never>()
        let onChangeColor = PassthroughSubject<CGColor, Never>()
        let onSaveTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var name = ""
        var color: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
