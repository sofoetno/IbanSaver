//
//  LoginView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import SwiftUI

struct RegistrationCompleted: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true), value: scale)
                .onAppear {
                    scale = 3
                }
            
            Text("Success")
                .foregroundColor(.green)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct RegisterView: View {
    
    // MARK: - Properties
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var showAlert = false
    @State private var registrationSuccess = false
    
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            if registrationSuccess {
                RegistrationCompleted()
            }
            
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
                Task {
                    let result = await registerViewModel.signUp()
                    switch result {
                    case .success:
                        print("")
                        registerViewModel.clearForm()
                        registrationSuccess = true
                        
                    case .failure:
                        showAlert = true
                        registerViewModel.clearForm()
                    }
                }
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Registration incomplete. Please try again."), dismissButton: .default(Text("OK")))
            }
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
