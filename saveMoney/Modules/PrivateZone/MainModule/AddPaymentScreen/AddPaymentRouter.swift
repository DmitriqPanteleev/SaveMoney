//
//  AddPaymentRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 05.05.2023.
//

import Foundation

protocol AddPaymentRouter: AnyObject {
    func pop()
}

extension HomeCoordinator: AddPaymentRouter {
    func pop() {
        self.popLast(nil)
    }
}
