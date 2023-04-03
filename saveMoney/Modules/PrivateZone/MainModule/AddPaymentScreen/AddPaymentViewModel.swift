//
//  AddPaymentViewModel.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import Foundation
import Combine

final class AddPaymentViewModel: ObservableObject {
    
    
    
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - Init
    init(isEditing: Bool,
         payment: Payment? = nil) {
        self.input = Input()
        
        if isEditing {
            self.output = Output(payment: payment, isEditing: isEditing)
        } else {
            self.output = Output(payment: .empty(), isEditing: isEditing)
        }
        
        bind()
    }
}

private extension AddPaymentViewModel {
    func bind() {
        
    }
}

extension AddPaymentViewModel {
    struct Input {
        
    }
    
    struct Output {
        var payment: Payment?
        var isEditing: Bool
    }
}
