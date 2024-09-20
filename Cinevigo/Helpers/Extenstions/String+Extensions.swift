//
//  String+Extensions.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation

extension String {
    
    var data: Data {
        guard let data = self.data(using: .utf8) else { return Data() }
        return data
    }
    
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, range: range) != nil
    }
    
}
