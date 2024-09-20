//
//  APIConfiguration.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import Alamofire

//MARK: - API Constants
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
    case multipartFormDataEncode = "multipart/form-data"
}

enum RequestParams {
    case body(_: Parameters?)
    case formData(_: Parameters?)
}

enum Token {
    case require
    case none
}

protocol APIConfiguration: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var AccessToken: Token { get }
    func asURLRequest() throws -> URLRequest
}

extension Encodable {
    var asDictionary: [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label: String?, value: Any) -> (String, Any)? in
            guard let key = label else { return nil }
            return (key, value)
        }).compactMap { $0 })
        return dict
    }
    
    var asNestedDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        forEach({ output += "\($0.key)=\($0.value)&" })
        output = String(output.dropLast())
        return output
    }
}
