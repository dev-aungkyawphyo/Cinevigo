//
//  RegisterViewModel.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 21/09/2024.
//

import Foundation
import ObjectMapper

protocol RegisterViewModelInputs: AnyObject {
    func clickedProfileButton()
    func clickedRegisterButton(input: RegisterInput)
}

protocol RegisterViewModelOutputs: AnyObject {
    var isInValid: ((Error) -> Void)? { get set }
    var isLoading: ((Bool) -> Void)? { get set }
    var apiError: ((NetworkingErrors) -> Void)? {get set }
}

protocol RegisterViewModelType {
    var inputs: RegisterViewModelInputs { get }
    var outputs: RegisterViewModelOutputs { get }
}

final class RegisterViewModel: RegisterViewModelInputs, RegisterViewModelOutputs, RegisterViewModelType {
    
    // MARK: - LoginViewModelType
    var inputs: RegisterViewModelInputs { return self }
    var outputs: RegisterViewModelOutputs { return self }
    
    //  MARK: - Custom Initializers
    let validationService = ValidationService.shared
    
    /// validation Flag
    var isInvalidInput: Bool = false
    
    // MARK: - LoginViewModelInputs
    func clickedProfileButton() {
        
    }
    
    func clickedRegisterButton(input: RegisterInput) {
        inputValidation(input: input)
    }
    
    // MARK: - LoginViewModelOutputs
    var isInValid : ((Error) -> Void)?
    var isLoading : ((Bool) -> Void)?
    var apiError : ((NetworkingErrors) -> Void)?
    
    func inputValidation(input: RegisterInput) {
        isInvalidInput = false
        
        /// Validation Check
        validateName(input.name)
        validatePhoneNo(input.phoneNo)
        validatePassword(input.password)
        validateConfirmPassword(input.confirmPassword)
        validateComparePasswords(password: input.password, confirmPassword: input.confirmPassword)
        
        guard !isInvalidInput else { return }
        
        // Register API Call
        registerAPICall(input: input)
    }
    
    func validateName(_ userName: String?) {
        switch validationService.isValidName(name: userName) {
        case .failure(let error):
            validateFail(error: error)
        default:
            break
        }
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
    
    private func validateConfirmPassword(_ confirmPassword: String?) {
        switch validationService.isValidPassword(passwordType: .confirmPassword, password: confirmPassword) {
        case .failure(let error):
            validateFail(error: error)
        default:
            break
        }
    }
    
    private func validateComparePasswords(password: String? , confirmPassword: String?) {
        switch validationService.comparePasswords(password: password, confirmPassword: confirmPassword) {
        case .failure(let errror):
            validateFail(error: errror)
        default:
            break
        }
    }
    
    private func validateFail(error: Error) {
        isInvalidInput = true
        self.isInValid?(error)
    }
    
    private func registerAPICall(input: RegisterInput) {
        guard let imageData = input.profilePhoto?.jpegData(compressionQuality: 0.5) else {
            debugPrint("Could not get JPEG representation of UIImage")
            return
        }
        let registerRequest = RegisterRequest(name: input.name, phone: input.phoneNo, password: input.password, confirmPassword: input.confirmPassword, profile: imageData)
        self.isLoading?(true)
        APIClient.register(request: registerRequest) { [weak self] result in
            self?.isLoading?(false)
            switch result {
            case .success(let data):
                printDebug(data.toJSON())
//                if let error = data.errorAuth, let errorMessage = error.body {
//                    self?.apiError?(errorMessage.responseError)
//                    return
//                }
                printDebug("API was success")
            case .failure(let error):
                self?.isLoading?(false)
                printDebug(error)
                self?.apiError?(error)
            }
        }
    }
    
}

