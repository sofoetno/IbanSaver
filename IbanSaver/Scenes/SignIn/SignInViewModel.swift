//
//  SignInViewwModel.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import Firebase

final class SignInViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var isActive = false
    @Published var showAlert = false
    var error = ""
    
    // MARK: - Sign In Function
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.error = error.localizedDescription
                self.showAlert = true
            } else if let user = result?.user {
                self.isActive = true
            }
        }
    }
    
    func faceID() {
        // FaceID Logic
    }
}
