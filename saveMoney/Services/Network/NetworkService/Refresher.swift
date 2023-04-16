//
//  Refresher.swift
//
//
//  Created by Дмитрий Яровой on 11/30/22.
//

import Foundation

protocol Refreshable {
    func refresh(withRefreshToken token: String, accessToken: String?) async throws -> AuthToken
}

final class Refresher: Refreshable {
    
    init() {}
    
    func refresh(withRefreshToken token: String, accessToken: String?) async throws -> AuthToken {
        let endpoint = RefreshTokenEndpoint.refreshToken(withRefreshToken: token)
        
        do {
            let request = try await request(from: endpoint, accessToken: accessToken)
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(ServerResponse<AuthToken>.self, from: data) else {
                    throw RequestError.decode
                }
                
                let result = decodedResponse.data
                print("------ Refreshed! ------")
                return result
            default:
                throw RequestError.invalidToken
            }
            
        } catch {
            throw RequestError.invalidToken
        }
    }
    
    func request(from endpoint: Endpoint, accessToken: String?) async throws -> URLRequest {
        
        guard let accessToken: String = accessToken else {
            throw RequestError.invalidToken
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        var header = endpoint.header ?? [:]
        
        header["Authorization"] = "JWT " + accessToken
        
        request.allHTTPHeaderFields = header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
}
