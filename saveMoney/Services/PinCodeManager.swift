//
//  PinCodeManager.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation

struct PinCodeManager {
    static var shared = PinCodeManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    var pinCode: String {
        get {
            defaults.string(forKey: DefaultsKeys.pinCode.rawValue) ?? ""
        }
        set {
            defaults.set(newValue, forKey: DefaultsKeys.pinCode.rawValue)
        }
    }
}

fileprivate enum DefaultsKeys: String {
    case pinCode
}
