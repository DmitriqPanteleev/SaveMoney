//
//  KeychainKeyStorage.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation

struct KeychainKeyStorage {
    static func set() {
        if UserDefaults.standard.string(forKey: "keychainKey") == nil {
            UserDefaults.standard.set(UUID().uuidString, forKey: "keychainKey")
        }
    }
    
    static func get() -> String {
        UserDefaults.standard.string(forKey: "keychainKey") ?? ""
    }
}
