//
//  BiometricAuthenticationError.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation

enum BiometricAuthenticationError: Error {
    case deniedAccess
    case noFaceIdEnrolled
    case biometricError
    
    var errorDescription: Strings {
        switch self {
        case .deniedAccess:
            return .accessDenied
        case .noFaceIdEnrolled:
            return .openSettingsAndEnrollFaceId
        case .biometricError:
            return .faceNotRecognized
        }
    }
}
