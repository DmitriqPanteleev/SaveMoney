//
//  Token.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation

struct Token {
    let accessToken: String
    
    var isEmpty: Bool {
        accessToken.isEmpty
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }

    static func empty() -> Token {
        return Token(accessToken: "")
    }
}
