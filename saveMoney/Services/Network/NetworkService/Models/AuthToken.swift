//
//  File.swift
//
//
//  Created by Дмитрий Яровой on 11/29/22.
//

import Foundation

struct AuthToken: Codable {
    let accessToken: String?
    let refreshToken: String?
    let expiresIn: Double?
    
    var isValid: Bool {
        guard let expiresIn = expiresIn else { return false }
        return Date() < Date(timeIntervalSince1970: expiresIn)
    }
}
