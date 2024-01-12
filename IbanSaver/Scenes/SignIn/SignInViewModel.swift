//
//  SignInViewwModel.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import SwiftUI
import Firebase
import UIKit

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isActive = false
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { Result, error in
            switch Result {
            case.none:
                print("X")
            case.some(let data):
                
                print(data.user.email, "Success")
                //self.push(viewController: UIHostingController(rootView: SignInView()), animated: true)
                
            }
            if let error = error {
                print(error, "sdasdasd")
            }
        }
    }
    
}
