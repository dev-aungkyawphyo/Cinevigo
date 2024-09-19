//
//  LoginScreenViewController.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import UIKit

class LoginScreenViewController: CineViewController {

    // MARK: - IBOutlets
    @IBOutlet var textFieldCollection: [CineTextField]!
    @IBOutlet var errorLabelCollection: [UILabel]!
    
    @IBOutlet weak var phoneNumberTextField: CineTextField!
    @IBOutlet weak var passwordTextField: CineTextField!
    
    @IBOutlet weak var phoneNoErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var logoImageView: CineImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    


}
