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
    
    var viewModel: LoginViewModel?
    
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
    @IBAction func forgotPasswordBtnAction(_ sender: UIButton) {
        printDebug("Forgot Password")
    }
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        printDebug("Register")
        let registerVC = RegisterScreenViewController.instantiate(storyboard: .register)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: CineButton) {
        printDebug("Login")
        viewModel?.inputs.clickedLoginButton(input: .init(phoneNo: phoneNumberTextField.inputValue, password: passwordTextField.inputValue))
    }
    
    private func binding() {
        viewModel = LoginViewModel()
        viewModel?.outputs.isInValid = { [weak self] errorMesage in
            if let error = errorMesage as? PhoneNoValidationError {
                self?.phoneNoErrorLabel.text = error.rawValue
                return
            }
            if let error = errorMesage as? PasswordValidationError {
                self?.passwordErrorLabel.text = error.rawValue
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
extension LoginScreenViewController: UITextFieldDelegate {
    
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
