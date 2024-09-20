//
//  MapperObject.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import ObjectMapper

class MapperObject: Mappable {
    
    var errorAuth: ErrorAuth?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        errorAuth <- map["error_auth"]
    }
    
}

class Body: MapperObject {
    
    var status: String?
    var message: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        status <- map["status"]
        message <- map ["message"]
    }
    
}

class ErrorAuth: MapperObject {
    
    var statusCode: Int?
    var body: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        statusCode <- map["http_status_code"]
        body <- map["http_body"]
    }
    
}
