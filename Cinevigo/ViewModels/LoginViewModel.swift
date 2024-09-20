//
//  LoginViewModel.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 21/09/2024.
//

import Foundation
import ObjectMapper

protocol LoginViewModelInputs: AnyObject {
    func clickedLoginButton(input: LoginInput)
    func clickedRegisterButton()
}

protocol LoginViewModelOutputs: AnyObject {
    var isInValid: ((Error) -> Void)? { get set }
    var isLoading: ((Bool) -> Void)? { get set }
    var apiError: ((NetworkingErrors) -> Void)? {get set }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    
    // MARK: - LoginViewModelType
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    //  MARK: - Custom Initializers
    let validationService = ValidationService.shared
    
    /// validation Flag
    var isInvalidInput: Bool = false
    
    // MARK: - LoginViewModelInputs
    func clickedLoginButton(input: LoginInput) {
        inputValidation(input: input)
    }
    
    func clickedRegisterButton() {
        
    }
    
    // MARK: - LoginViewModelOutputs
    var isInValid : ((Error) -> Void)?
    var isLoading : ((Bool) -> Void)?
    var apiError : ((NetworkingErrors) -> Void)?
    
    func inputValidation(input: LoginInput) {
        isInvalidInput = false
        /// Validation Check
        validatePhoneNo(input.phoneNo)
        validatePassword(input.password)
        
        guard !isInvalidInput else { return }
        
        /// Login API Call
        loginAPICall(input: input)
    }
    
    private func validatePhoneNo(_ phoneNo: String?) {
        switch validationService.isValidPhoneNo(phoneNo: phoneNo) {
        case .failure(let error):
            validateFail(error: error)
        default:
            break
        }
    }
    
    private func validatePassword(_ password: String?) {
        switch validationService.isValidPassword(passwordType: .normalPassword, password: password) {
        case .failure(let error):
            validateFail(error: error)
        default:
            break
        }
    }
    
    private func validateFail(error: Error) {
        isInvalidInput = true
        self.isInValid?(error)
    }
  
    
    private func loginAPICall(input: LoginInput) {
        /*
         - demo   registered account: 959796259039, password: 1qazXSW@
         */
        let loginRequest = LoginRequest(phone: input.phoneNo, password: input.password)
        self.isLoading?(true)
        APIClient.login(request: loginRequest) { [weak self] result in
            self?.isLoading?(false)
            switch result {
            case .success(let data):
                printDebug(data.toJSON())
                if let error = data.errorAuth, let errorMessage = error.body {
                    self?.apiError?(errorMessage.responseError)
                    return
                }
                printDebug("API was success")
            case .failure(let error):
                self?.isLoading?(false)
                printDebug(error)
                self?.apiError?(error)
            }
        }
    }
    
}

