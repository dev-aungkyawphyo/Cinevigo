//
//  RegisterScreenViewController.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import UIKit

class RegisterScreenViewController: CineViewController {

    // MARK: - IBOutlets
    @IBOutlet var textFieldCollection: [CineTextField]!
    @IBOutlet var errorLabelCollection: [UILabel]!
    
    @IBOutlet weak var nameTextField: CineTextField!
    @IBOutlet weak var phoneNumberTextField: CineTextField!
    @IBOutlet weak var passwordTextField: CineTextField!
    @IBOutlet weak var confirmPasswordTextField: CineTextField!
    
    @IBOutlet weak var namneErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var profileImageView: CineImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  
}
