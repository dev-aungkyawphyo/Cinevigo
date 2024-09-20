//
//  RegisterModel.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation
import UIKit
import ObjectMapper

struct RegisterInput {
    let name: String
    let phoneNo: String
    let password: String
    let confirmPassword: String
    let profilePhoto: UIImage?
}

struct RegisterRequest: Codable {
    let name: String
    let phone: String
    let password: String
    let confirmPassword: String
    let profile: Data
    
    enum CodingKeys: String, CodingKey {
        case confirmPassword = "confirm_password"
        case phone, password, name, profile
    }
}

// MARK: - Login Response Mappable
class RegisterResponse: MapperObject {
    
    var user: User?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <- map["user"]
    }
    
}

class User: MapperObject {
    
    var createData: String = ""
    var id: Int = 0
    var name: String = ""
    var phone: String = ""
    var profile: String = ""
    var updateData: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        createData <- map["created_at"]
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        profile <- map["profile"]
        updateData <- map["updated_at"]
    }
    
}

