//
//  BiometricAuthenticationService.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation
import Combine
import LocalAuthentication

final class BiometricAuthenticationService {
    
    var isFaceIdAvaliable: Bool {
        let context = LAContext()
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                          error: nil)
        
        switch context.biometryType {
        case .faceID: return true
        default: return false
        }
    }
    
    func requestBiometricUnlock() async throws -> Bool {
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                    error: &error)

        if let error = error {
            switch error.code {
            case -6: throw BiometricAuthenticationError.deniedAccess
            case -7: throw BiometricAuthenticationError.noFaceIdEnrolled
            default: throw BiometricAuthenticationError.biometricError
            }
        }

        if canEvaluate {
            if context.biometryType == .faceID {
                return try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                        localizedReason: "Для входа в приложение")
            } else {
                throw BiometricAuthenticationError.biometricError
            }
        } else {
            throw BiometricAuthenticationError.deniedAccess
        }
    }
}
