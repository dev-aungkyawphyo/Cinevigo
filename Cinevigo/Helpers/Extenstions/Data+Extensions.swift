//
//  Data+Extensions.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 20/09/2024.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: Any {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: [.allowFragments]),
              let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) else { return "Can't Convert Pretty Print JSON String" }
        return prettyPrintedString
    }
}
