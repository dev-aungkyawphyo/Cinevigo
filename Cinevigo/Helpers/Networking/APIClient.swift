//
//  APIClient.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import Alamofire
import ObjectMapper

class APIClient {
    
    static var sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForResource = 30
        return Session(configuration: configuration, eventMonitors: [AlamofireLogger()])
    }()
    
    static let statusCodes = (0...500).filter { $0 != 401 }
    
    private static func handleDataResponse<T: Mappable>(_ responseData: AFDataResponse<Data?>, _ completion: @escaping (Result<T, NetworkingErrors>) -> Void) {
        switch responseData.result {
        case .success(let data):
            do {
                guard let data = data else {
                    completion(.failure(NetworkingErrors.customError(CustomErrorMessage.cannotConvertData)))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                    completion(.failure(NetworkingErrors.customError(CustomErrorMessage.cannotConvertJson)))
                    return
                }
                guard let mapper = Mapper<T>().map(JSON: json) else {
                    completion(.failure(NetworkingErrors.customError(CustomErrorMessage.cannotConvertJsontoObject)))
                    return
                }
                completion(.success(mapper))
            } catch {
                completion(.failure(NetworkingErrors.returnedError(error)))
            }
        case .failure(let error):
            completion(.failure(NetworkingErrors.returnedError(error)))
        }
    }
    
    private static func formRequest<T: Mappable>(_ router: APIRouter, _ completion: @escaping (Result<T, NetworkingErrors>) -> Void) {
        sessionManager.upload(multipartFormData: { multipartFormData in
            switch router {
            case .login(let loginRequest):
                multipartFormData.append(loginRequest.phone.data, withName: FormDataName.phone)
                multipartFormData.append(loginRequest.password.data, withName: FormDataName.password)
            case .register(let registerRequest):
                multipartFormData.append(registerRequest.name.data, withName: FormDataName.name)
                multipartFormData.append(registerRequest.phone.data, withName: FormDataName.phone)
                multipartFormData.append(registerRequest.password.data, withName: FormDataName.password)
                multipartFormData.append(registerRequest.confirmPassword.data, withName: FormDataName.confirmPassword)
                multipartFormData.append(registerRequest.profile, withName: "file", fileName: "image.jpeg", mimeType: "image/png")
            }
            
        }, with: router).validate(statusCode: statusCodes).response { responseData in
            handleDataResponse(responseData, completion)
        }
    }
    
    /// Static request decalare at here ...
    static func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkingErrors>) -> Void) {
        formRequest(.login(request), completion)
    }
    
    static func register(request: RegisterRequest, completion: @escaping (Result<RegisterResponse, NetworkingErrors>) -> Void) {
        formRequest(.register(request), completion)
    }
    
}





