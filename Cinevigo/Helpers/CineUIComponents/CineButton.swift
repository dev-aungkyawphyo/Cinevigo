//
//  CineButton.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 19/09/2024.
//

import UIKit

@IBDesignable
class CineButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.setTitleColor(.appColor(.btnTextColor), for: .normal)
        self.backgroundColor = .appColor(.primaryTextColor)
        self.layer.cornerRadius = 22
    }
    
}

