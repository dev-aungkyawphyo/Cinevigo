//
//  CineTextField.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 19/09/2024.
//

import UIKit

@IBDesignable
class CineTextField: UITextField {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0
    
    @IBInspectable
    var leftImage: UIImage? {
        didSet {
            if let leftImage {
                addImage(image: leftImage)
                return
            }
            leftViewMode = .never
        }
    }
    
    @IBInspectable
    var isPhoneNumber: Bool = false {
        didSet {
            if isPhoneNumber {
                addLabel(text: "+95")
                return
            }
            leftViewMode = .never
        }
    }
    
    @IBInspectable
    var addVisible: Bool = false {
        didSet {
            if addVisible {
                addVisibleBtn()
                return
            }
        }
    }
    
    @IBInspectable
    var leftPadding: CGFloat = 0
    
    @IBInspectable
    var rightPadding: CGFloat = 0
    
    @IBInspectable
    var color: UIColor = UIColor.lightGray {
        didSet {
            // Update color
        }
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUnderLine()
    }
    
    private func addVisibleBtn() {
        let visibleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        visibleBtn.setImage(UIImage(named: "Close_Eye"), for: .selected)
        visibleBtn.imageView?.tintColor = .appColor(.primaryTextColor)
        visibleBtn.setImage(UIImage(named: "Open_Eye"), for: .normal)
        visibleBtn.isSelected = true
        isSecureTextEntry = visibleBtn.isSelected
        visibleBtn.addTarget(self, action: #selector(visibleBtnAction(_:)), for: .touchUpInside)
        rightViewMode = .always
        rightView = visibleBtn
    }
        
    @objc private func visibleBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = sender.isSelected
    }
    
    private func addImage(image: UIImage) {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        imageView.tintColor = .appColor(.primaryTextColor)
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)
        container.center = imageView.center
        imageView.image = image
        leftViewMode = .always
        leftView = container
    }
    
    private func addLabel(text: String) {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        ///Label for the phonenumber field
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15)
        container.addSubview(label)
        container.center = label.center
        leftViewMode = .always
        leftView = container
    }
    
    private func configure() {
        setUnderLine()
        borderStyle = .none
        layer.borderColor = UIColor.clear.cgColor
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
}
