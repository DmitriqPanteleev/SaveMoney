//
//  HTTPClient.swift
//  Doors
//
//  Created by Дмитрий Пантелеев on 15.02.2023.
//

import Foundation
import Combine

protocol HTTPClient {
    func sendRequest<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

class HTTPClientAuthImpl: HTTPClient {
    
    private let authManager: AuthManager
    private let connectionManager: ConnectionManager = ConnectionManager()
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    private func load(_ endpoint: Endpoint, allowRetry: Bool = true) async throws -> (Data, URLResponse) {
        let request = try await request(from: endpoint)
        
        #if DEBUG
        print(request.cURL(pretty: true))
        #endif
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
        
        if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 401 {
            if allowRetry {
                _ = try await authManager.refreshToken()
                return try await load(endpoint, allowRetry: false)
            }
            throw RequestError.invalidToken
        }
        
        return (data, urlResponse)
    }
    
    private func request(from endpoint: Endpoint) async throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.port = 49460
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        print(urlComponents)
        
        if let queryDict = endpoint.query {
            urlComponents.queryItems = []
            for query in queryDict {
                urlComponents.queryItems?.append(URLQueryItem(name: query.key, value: query.value))
            }
        }
        
        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        var _ = try await connectionManager.checkConnection()
        
        let token = try await authManager.validToken()
        
        var header = endpoint.header ?? [:]
        
        if let accessToken = token?.accessToken {
            print(accessToken)
            header["token"] = accessToken
        }
        
        request.allHTTPHeaderFields = header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
    func sendRequest<T: Codable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        
        do {
            let (data, response) = try await load(endpoint)
            
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
#if DEBUG
            print(data.prettyPrintedJSONString ?? "")
#endif
            
            switch response.statusCode {
            case 200...299:
                
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return decodedResponse
                } catch {
                    print(error)
                    throw RequestError.decode
                }
                
            case 403:
                authManager.authorizationState.send(.unauthorized)
                throw RequestError.unauthorized
            default:
                
                let decodedResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                let messages = decodedResponse?["messages"] as? [String]
                
                throw RequestError.unexpectedStatusCode(statusCode: response.statusCode, message: messages?.first)
            }
            
        } catch {
            throw error
        }
    }
}

class HTTPClientImpl: HTTPClient {
    
    private let connectionManager: ConnectionManager = ConnectionManager()
    
    private func load(_ endpoint: Endpoint, allowRetry: Bool = true) async throws -> (Data, URLResponse) {
        let request = try await request(from: endpoint)
        
        #if DEBUG
        print(request.cURL(pretty: true))
        #endif
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
        
        return (data, urlResponse)
    }
    
    private func request(from endpoint: Endpoint) async throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.port = 49460
        urlComponents.path = endpoint.path
        
        if let queryDict = endpoint.query {
            urlComponents.queryItems = []
            for query in queryDict {
                urlComponents.queryItems?.append(URLQueryItem(name: query.key, value: query.value))
            }
        }
        
        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let _ = try await connectionManager.checkConnection()
        
        request.allHTTPHeaderFields = endpoint.header ?? [:]
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
    func sendRequest<T: Codable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        
        do {
            let (data, response) = try await load(endpoint)
            
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
#if DEBUG
            print(data.prettyPrintedJSONString ?? "")
#endif
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RequestError.decode
                }
                
                return decodedResponse
            default:
                
                let decodedResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                let messages = decodedResponse?["messages"] as? [String]
                
                throw RequestError.unexpectedStatusCode(statusCode: response.statusCode, message: messages?.first)
            }
            
        } catch {
            throw error
        }
    }
}

