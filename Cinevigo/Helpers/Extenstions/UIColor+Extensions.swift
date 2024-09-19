//
//  UIColor+Extensions.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 19/09/2024.
//

import Foundation
import UIKit

extension UIColor {
    
    static func appColor(_ name: AssetColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
}
