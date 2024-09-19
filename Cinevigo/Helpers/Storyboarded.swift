//
//  Storyboarded.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import Foundation
import UIKit

enum Storyboard: String {
    case login = "LoginScreen"
    case register = "RegisterScreen"
    
    var name: String {
        self.rawValue
    }
}

protocol Storyboarded {
    static func instantiate(storyboard: Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)
        return storyboard.instantiateViewController(offType: Self.self)
    }
    
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(offType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
