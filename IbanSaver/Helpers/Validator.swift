//
//  PasswordSecurity .swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 11.01.24.
//

import Foundation
import SwiftUI

struct Validator {
    
    // MARK: - Methods
    static func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return isValid(value: email, regex: emailRegex)
    }
    
    static func validatePassword(password: String) -> PasswordValidationStatus {
        PasswordValidationStatus(containsNumber: checkNumbers(password: password),
                                 containsSymbol: checkSymbols(password: password),
                                 containsUppercase: checkUppercase(password: password),
                                 containsLowercase: checkLowercase(password: password),
                                 passwordLength: checkLength(password: password)
        )
    }
    
    static private func isValid(value: String, regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let range = NSRange(location: 0, length: value.utf16.count)
            let matches = regex.matches(in: value, range: range)
            
            return matches.count > 0
        } catch {
            print("Error creating regular expression: \(error.localizedDescription)")
            return false
        }
    }
    
    
    static private func checkNumbers(password: String) -> Bool {
        let numberRegEx  = ".*[0-9]+.*"
        return isValid(value: password, regex: numberRegEx)
    }
    
    static private func checkSymbols(password: String) -> Bool {
        let numberRegEx  = ".*[^A-Za-z0-9].*"
        return isValid(value: password, regex: numberRegEx)
    }
    
    static private func checkUppercase(password: String) -> Bool {
        let numberRegEx  = "[A-Z]+"
        return isValid(value: password, regex: numberRegEx)
    }
    
    static private func checkLowercase(password: String) -> Bool {
        let numberRegEx  = "[a-z]+"
        return isValid(value: password, regex: numberRegEx)
    }
    
    static private func checkLength(password: String) -> Bool {
        return password.count >= 8
    }
    
}









