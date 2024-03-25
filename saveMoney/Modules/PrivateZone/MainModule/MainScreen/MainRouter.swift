//
//  MainRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 02.04.2023.
//

import Foundation

protocol MainRouter: AnyObject {
    func pushToAddPayment()
}

extension HomeCoordinator: MainRouter {
    func pushToAddPayment() {
        self.route(to: \.addPayment)
    }
}
