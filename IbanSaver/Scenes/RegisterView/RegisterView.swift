//
//  LoginView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: - Properties
    @StateObject private var registerViewModel = RegisterViewModel()
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            VStack {
                TextField("Enter your Email", text: $registerViewModel.email)
                    .onChange(of: registerViewModel.email, { oldValue, newValue in
                        registerViewModel.isEmailValid = Validator.validateEmail(email: newValue)
                    })
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                SecureField("Password...", text: $registerViewModel.password)
                    .onChange(of: registerViewModel.password) { oldValue, newValue in
                            
                        registerViewModel.passwordStatus = Validator.validatePassword(password: newValue)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            .padding(.vertical, 10)

            VStack(alignment: .leading, spacing: 10) {
                displayPasswordValidation(title: "Uppercase", conditation: registerViewModel.passwordStatus.containsUppercase)
                
                displayPasswordValidation(title: "Lowercase", conditation: registerViewModel.passwordStatus.containsLowercase)
                
                displayPasswordValidation(title: "Numbers", conditation: registerViewModel.passwordStatus.containsNumber)
                
                displayPasswordValidation(title: "Symbols(?#@...)", conditation: registerViewModel.passwordStatus.containsSymbol)
                
                displayPasswordValidation(title: "Min 8 characters", conditation: registerViewModel.passwordStatus.passwordLength)

            }
            .foregroundColor(.red)
            .padding(.vertical, 20)
                

            
            Button {
                registerViewModel.signUp()
            } label: {
                Text("Register")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(registerViewModel.isFormValid() ? Color.green : Color.red)
                    .cornerRadius(10)
            }
            .disabled(!registerViewModel.isFormValid())
        }
        .padding()
    }
    
    // MARK: - Methods
    func displayPasswordValidation(title: String, conditation: Bool) -> some View {
        Label(title, systemImage: conditation ? "checkmark.seal" : "x.square")
            .foregroundColor(conditation ? .green : .red)
    }
}

// MARK: - Preview
#Preview {
    RegisterView()
}
