//
//  PasswordValidationStatus.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 11.01.24.
//

import Foundation

struct PasswordValidationStatus {
    
    // MARK: - Properties
    var containsNumber: Bool = false
    var containsSymbol: Bool = false
    var containsUppercase: Bool = false
    var containsLowercase: Bool = false
    var passwordLength: Bool = false
    var isPasswordValid: Bool {
        containsNumber && containsSymbol && containsUppercase && containsLowercase && passwordLength
    }
}
