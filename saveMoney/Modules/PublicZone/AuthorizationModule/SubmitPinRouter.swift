//
//  SubmitPinRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation

import Foundation

protocol SubmitPinRouter: AnyObject {
    func closeCoordinator(with token: Token?)
}

extension AuthorizationCoordinator: SubmitPinRouter {
    func closeCoordinator(with token: Token?) {
        self.authorizationState.send(.authorized(token: token))
    }
}
