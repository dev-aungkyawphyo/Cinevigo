//
//  PasswordType.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 21/09/2024.
//

import Foundation

enum PasswordType {
    
    case normalPassword, confirmPassword, newPassword
    
    var emptyPasswordError: Error {
        switch self {
        case .normalPassword:
            return PasswordValidationError.emptyPassword
        case .confirmPassword:
            return ConfirmPasswordValidationError.emptyPassword
        case .newPassword:
            return NewPasswordValidationError.emptyPassword
        }
    }
    
    var shortPasswordError: Error {
        switch self {
        case .normalPassword:
            return PasswordValidationError.shortPassword
        case .confirmPassword:
            return ConfirmPasswordValidationError.shortPassword
        case .newPassword:
            return NewPasswordValidationError.shortPassword
        }
    }
    
    var longPasswordError: Error {
        switch self {
        case .normalPassword:
            return PasswordValidationError.longPassword
        case .confirmPassword:
            return ConfirmPasswordValidationError.longPassword
        case .newPassword:
            return NewPasswordValidationError.longPassword
        }
    }
    
    var passwordWithSpaceError: Error {
        switch self {
        case .normalPassword:
            return PasswordValidationError.passwordWithSpace
        case .confirmPassword:
            return ConfirmPasswordValidationError.passwordWithSpace
        case .newPassword:
            return NewPasswordValidationError.passwordWithSpace
        }
    }
    
    var passwordWithNoAlphabetOrDigitError: Error {
        switch self {
        case .normalPassword:
            return PasswordValidationError.passwordWithNoAlphabetOrDigit
        case .confirmPassword:
            return ConfirmPasswordValidationError.passwordWithNoAlphabetOrDigit
        case .newPassword:
            return NewPasswordValidationError.passwordWithNoAlphabetOrDigit
        }
    }
    
}
