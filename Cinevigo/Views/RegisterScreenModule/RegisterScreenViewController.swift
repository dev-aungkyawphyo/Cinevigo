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
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var profileImageView: CineImageView!
    
    var viewModel: RegisterViewModel?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetup()
    }
    
    private func defaultSetup() {
        setupTextFields()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBAction
    @IBAction func profileBtnAction(_ sender: UIButton) {
        printDebug("choose image from photos")
    }
    
    @IBAction func registerBtnAction(_ sender: CineButton) {
        let input: RegisterInput = .init(name: nameTextField.inputValue, phoneNo: phoneNumberTextField.inputValue, password: passwordTextField.inputValue, confirmPassword: confirmPasswordTextField.inputValue, profilePhoto: UIImage(named: "profile"))
        let mockInput: RegisterInput = .init(name: "testUser", phoneNo: "123456789", password: "abcdef@12345", confirmPassword: "abcdef@12345", profilePhoto: UIImage(named: "profile"))
        viewModel?.inputs.clickedRegisterButton(input: mockInput)
    }
    
    private func binding() {
        viewModel = RegisterViewModel()
        viewModel?.outputs.isInValid = { [weak self] errorMesage in
            if let error = errorMesage as? NameValidationError {
                self?.nameErrorLabel.text = error.rawValue
                return
            }
            if let error = errorMesage as? PhoneNoValidationError {
                self?.phoneNumberErrorLabel.text = error.rawValue
                return
            }
            if let error = errorMesage as? PasswordValidationError {
                self?.passwordErrorLabel.text = error.rawValue
                return
            }
            if let error = errorMesage as? ConfirmPasswordValidationError {
                self?.confirmPasswordErrorLabel.text = error.rawValue
            }
        }
        viewModel?.outputs.isLoading = { [weak self] isLoading in
            isLoading ? self?.startLoading() : self?.stopLoading()
        }
        viewModel?.outputs.apiError = { [weak self] responseError in
            self?.showAlert(with: "Error!", message: responseError.errorDescription)
        }
    }
    
    private func setupTextFields() {
        textFieldCollection.forEach({
            $0.delegate = self
        })
    }
    
}

// MARK: - UITextFieldDelegate
extension RegisterScreenViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textField = textField as? CineTextField, let index = textFieldCollection.firstIndex(of: textField) {
            errorLabelCollection[index].text = ""
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? CineTextField, let index = textFieldCollection.firstIndex(of: textField) else { return true }
        guard index < textFieldCollection.count - 1 else {
            textFieldCollection[index].resignFirstResponder()
            return true
        }
        textFieldCollection[index + 1].becomeFirstResponder()
        return true
    }
    
}
