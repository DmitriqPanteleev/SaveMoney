//
//  CreatePinRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation

protocol CreatePinRouter: AnyObject {
    func closeCoordinator(with token: Token)
}

extension RegistrationCoordinator: CreatePinRouter {
    func closeCoordinator(with token: Token) {
        self.authorizationState.send(.authorized(token: token))
    }
}
