//
//  CineView.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 19/09/2024.
//

import UIKit

@IBDesignable
class CineView: UIView {
    
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
        self.layer.shadowColor = UIColor.appColor(.primaryTextColor)!.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 12
    }
    
}
