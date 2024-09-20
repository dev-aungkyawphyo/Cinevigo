//
//  NetworkingErrors.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import Alamofire
import ObjectMapper

struct CustomErrorMessage {
    static let cannotConvertJson = "Can't convert json"
    static let cannotConvertData = "Can't convert data"
    static let cannotConvertJsontoObject = "Can't convert json to object mapper"
}

enum NetworkingErrors: Error {
    case errorParsingJSON
    case noInternetConnection
    case dataReturnedNil
    case canNotProcessData
    case returnedError(Error)
    case invalidStatusCode(Int)
    case customError(String)
    case unexpected(code: Int)
}

extension NetworkingErrors {
    var isFatal: Bool {
        if case NetworkingErrors.unexpected = self { return true }
        else { return false }
    }
}

extension NetworkingErrors: CustomStringConvertible {
    var description: String {
        switch self {
        case .noInternetConnection:
            return "Please Check Your Internet Connection."
        case .dataReturnedNil:
            return "response data is nil."
        case .canNotProcessData:
            return "Cannot Process Data."
        case .returnedError(let error):
            if let err = error as? AFError {
                return String(describing: err)
            }
            return String(describing: error)
        case .unexpected(_):
            return "An unexpected error occurred."
        case .errorParsingJSON:
            return "Json Error."
        case .invalidStatusCode(_):
            return "Status Code."
        case .customError(let error):
            return error
        }
    }
}

extension NetworkingErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return description /// need to localized error
        case .dataReturnedNil:
            return description
        case .canNotProcessData:
            return description
        case .returnedError(let error):
            return error.localizedDescription
        case .errorParsingJSON:
            return description
        case .invalidStatusCode(_):
            return description
        case .customError(_):
            return description
        case .unexpected(_):
            return description
        }
    }
}

extension String {
    var responseError: NetworkingErrors {
        let body = Mapper<Body>().map(JSONString: self)
        return NetworkingErrors.customError(body?.message ?? "")
    }
}

