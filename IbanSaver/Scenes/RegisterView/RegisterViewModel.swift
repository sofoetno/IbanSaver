//
//  RegisterViewModel.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 11.01.24.
//

import SwiftUI

@MainActor
final class RegisterViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - Methods
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            print("Please enter valid Email address.")
            return
        }
        
        Task {
            do {
                let userData = try await AuthManager.shared.creatUser(email: email, password: password)
                print(userData)
            } catch {
                print(error)
            }
        }
    }
    
}
