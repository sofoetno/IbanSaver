//
//  SignInViewwModel.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import Firebase
import SwiftUI
import LocalAuthentication

enum AlertType {
    case mainAlert
    case IDAlert
    case IDFail
}

enum ForgotType {
    case fail
    case success
}

final class SignInViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var isActive = false
    @Published var showAlert = false
    @Published var forgotAlert = false
    var error = ""
    var policy = "This is policy"
    var IDEmail: String? = nil
    var IDPassword: String? = nil
    var wantID: Bool = false
    var alertType: AlertType?
    var forgotType: ForgotType?
    var forgotResponse = ""
    
    // MARK: - Sign In Function
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.error = error.localizedDescription
                
                self.alertType = .mainAlert
                self.showAlert = true
                
            } else if let user = result?.user {
                self.isActive = true
                
                if self.wantID == false {
                    self.alertType = .IDAlert
                    self.showAlert = true
                }
            }
        }
    }
    
    func faceID() {
        let scanner = LAContext()
        var error: NSError?
        
        if self.wantID == true {
            
            if scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: policy) { [weak self] result, authenticationError in
                    DispatchQueue.main.async {
                        if result{
                            // Successful Authentication
                            self?.signIn(email: self!.IDEmail!, password: self!.IDPassword!)
                        } else {
                            // Unsuccessful Auth
                            print(authenticationError?.localizedDescription ?? "")
                        }
                    }
                }
            } else {
                // cant use Auth
                print("Cant Auth")
            }
        } else {
            alertType = .IDFail
            showAlert = true
        }
    }
    
    func writeID() {
        self.wantID = true
        self.IDEmail = self.email
        self.IDPassword = self.password
    }
    
    func forgot() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                self.forgotResponse = error?.localizedDescription ?? ""
                self.forgotType = .success
                self.forgotAlert = true
            } else {
                self.forgotResponse = error?.localizedDescription ?? "Success"
                self.forgotType = .fail
                self.forgotAlert = true
            }
        }
    }
}
