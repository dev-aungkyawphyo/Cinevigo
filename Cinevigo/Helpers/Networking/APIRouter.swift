//
//  APIRouter.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case login(_ loginRequest: LoginRequest)
    case register(_ RegisterRequest: RegisterRequest)
    
    var baseURL: URL {
        guard let url = URL(string: "http://136.228.167.41:80") else {
            fatalError("Backend URL missing")
        }
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .login(let loginRequest):
            return .formData(loginRequest.asDictionary)
        case .register(let registerRequest):
            return .formData(registerRequest.asDictionary)
        }
    }
    
    // if you need to call the token set it
    var AccessToken: Token {
        switch self {
        default:
            return .none
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        /// HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        /// is require Access token
        if AccessToken == .require {
            /// token
        }
        
        switch parameters {
        case .body(let params):
            if let parameters = params {
                
                urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                    throw NetworkingErrors.canNotProcessData
                }
                urlRequest.httpBody = httpBody
            }
        case .formData(let params):
            if let params = params {
                
                urlRequest.setValue(ContentType.multipartFormDataEncode.rawValue,
                                    forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                
                let queryParams = params.map { pair in return URLQueryItem(name: pair.key, value: "\(pair.value)") }
                var urlComponent = URLComponents(string: baseURL.appendingPathComponent(path).absoluteString)
                urlComponent?.queryItems = queryParams
                urlRequest.url = urlComponent?.url
            }
        }
        
        printDebug("URL request from API Router", urlRequest)
        return urlRequest
    }
    
}

