//
//  AuthorizationState.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation

enum AuthorizationState {
    case unauthorized
    case authorized(token: Token?)
}

