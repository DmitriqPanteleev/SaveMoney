//
//  CreateProfileRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation
import Combine

protocol CreateProfileRouter: AnyObject {
    func pushToCreatePin(with token: Token)
}

extension RegistrationCoordinator: CreateProfileRouter {
    func pushToCreatePin(with token: Token) {
        self.route(to: \.createPin, token)
    }
}
