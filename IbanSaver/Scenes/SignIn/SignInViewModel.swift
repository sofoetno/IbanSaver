//
//  SignInViewwModel.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import SwiftUI
import Firebase

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { Result, error in
            switch Result {
            case.none:
                print("X")
            case.some(let data):
                
                print(data.user.email, "Success")
                
            }
            if let error = error {
                print(error, "sdasdasd")
            }
        }
    }
    
}
