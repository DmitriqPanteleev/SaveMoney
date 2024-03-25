//
//  RequestError.swift
//  RequestApp
//
//  Created by Victor Catão on 18/02/22.
//

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode(statusCode: Int, message: String?)
    case unknown
    case invalidToken
    case error(id: String)
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Что-то пошло не так"
        }
    }
}
