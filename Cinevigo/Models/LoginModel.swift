//
//  LoginModel.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import ObjectMapper

struct LoginRequest: Codable {
    let phone: String
    let password: String
}

struct LoginInput {
    let phoneNo: String
    let password: String
}

// MARK: - Login Response Mappable
class LoginResponse: MapperObject {
    
    var accessToken: String = ""
    var expire: Int = 0
    var refreshToken: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
        expire <- map["exp"]
        refreshToken <- map["refresh_token"]
    }
    
}
