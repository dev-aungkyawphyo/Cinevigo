//
//  ValidationError.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 21/09/2024.
//

import Foundation

enum PhoneNoValidationError: String, Error {
    case emptyPhoneNo = "pnve_emptyPhoneNo"
    case shortPhoneNo = "pnve_shortPhoneNo"
    case longPhoneNo = "pnve_longPhoneNo"
    case phoneNoWithInvalidChars = "pnve_phoneNoWithInvalidChars"
}

enum NameValidationError: String, Error {
    case emptyName = "nve_emptyName"
}

enum LoginPasswordValidationError: String, Error {
    case emptyPassword = "lpve_emptyPassword"
}

enum PasswordValidationError: String, Error {
    case emptyPassword = "pve_emptyPassword"
    case shortPassword = "pve_shortPassword"
    case longPassword = "pve_longPassword"
    case passwordWithSpace = "pve_passwordWithSpace"
    case passwordWithNoAlphabetOrDigit = "pve_passwordWithNoAlphabetOrDigit"
}

enum ConfirmPasswordValidationError: String, Error {
    case emptyPassword = "cpve_emptyPassword"
    case shortPassword = "cpve_shortPassword"
    case longPassword = "cpve_longPassword"
    case passwordWithSpace = "cpve_passwordWithSpace"
    case passwordWithNoAlphabetOrDigit = "cpve_passwordWithNoAlphabetOrDigit"
    case notMatched = "cpve_notMatched"
}

enum NewPasswordValidationError: String, Error {
    case emptyPassword = "npve_emptyPassword"
    case shortPassword = "npve_shortPassword"
    case longPassword = "npve_longPassword"
    case passwordWithSpace = "npve_passwordWithSpace"
    case passwordWithNoAlphabetOrDigit = "npve_passwordWithNoAlphabetOrDigit"
}
