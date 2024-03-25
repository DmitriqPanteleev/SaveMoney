//
//  KeychainManager.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation

import Foundation
import SwiftKeychainWrapper

protocol PinManagerProtocol {
    var userPinCode: String? { get set }
}

final class KeychainManger {
    private let wrapper: KeychainWrapper
    
    init(serviceName: String) {
        self.wrapper = KeychainWrapper(serviceName: serviceName)
    }
}

extension KeychainManger: PinManagerProtocol {
    var userPinCode: String? {
        get {
            wrapper.string(forKey: KeychainMangerKey.userPinCode.rawValue)
        }
        set {
            if let newValue = newValue {
                wrapper.set(newValue, forKey: KeychainMangerKey.userPinCode.rawValue)
            } else {
                wrapper.removeObject(forKey: KeychainMangerKey.userPinCode.rawValue)
            }
        }
    }
}

extension KeychainManger: KeychainManagerProtocol {
    var token: String? {
        get {
            wrapper.string(forKey: KeychainMangerKey.token.rawValue)
        }
        set {
            if let newValue = newValue {
                wrapper.set(newValue, forKey: KeychainMangerKey.token.rawValue)
            } else {
                wrapper.removeObject(forKey: KeychainMangerKey.token.rawValue)
            }
        }
    }
    
    var refreshToken: String? {
        get {
            wrapper.string(forKey: KeychainMangerKey.refreshToken.rawValue)
        }
        set {
            if let newValue = newValue {
                wrapper.set(newValue, forKey: KeychainMangerKey.refreshToken.rawValue)
            } else {
                wrapper.removeObject(forKey: KeychainMangerKey.refreshToken.rawValue)
            }
        }
    }
    
    var tokenExpiresIn: Double? {
        get {
            wrapper.double(forKey: KeychainMangerKey.tokenExpiresIn.rawValue)
        }
        set {
            if let newValue = newValue {
                wrapper.set(newValue, forKey: KeychainMangerKey.tokenExpiresIn.rawValue)
            } else {
                wrapper.removeObject(forKey: KeychainMangerKey.tokenExpiresIn.rawValue)
            }
        }
    }
    
    func clear() {
        wrapper.removeAllKeys()
    }
    
    
}

fileprivate enum KeychainMangerKey: String {
    case token
    case refreshToken
    case tokenExpiresIn
    
    case userPinCode
}
