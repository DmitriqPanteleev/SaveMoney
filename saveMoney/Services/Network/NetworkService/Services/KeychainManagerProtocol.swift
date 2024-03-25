//
//  File.swift
//
//
//  Created by Дмитрий Яровой on 12/2/22.
//

import Foundation

public protocol KeychainManagerProtocol {
    var token: String? { get set }
    var refreshToken: String? { get set }
    var tokenExpiresIn: Double? { get set }
    
    func clear()
}
