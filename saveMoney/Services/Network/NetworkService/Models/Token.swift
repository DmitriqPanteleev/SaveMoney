//
//  Token.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation

public struct Token {
    public let accessToken: String
    public let refreshToken: String
    public let expiresIn: Double
    
    public var isEmpty: Bool {
        accessToken.isEmpty
    }
    
    public init(accessToken: String, refreshToken: String, expiresIn: Double) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }

    static func empty() -> Token {
        return Token(accessToken: "", refreshToken: "", expiresIn: 0.0)
    }
}
