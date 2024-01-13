//
//  LoginView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import SwiftUI
struct RegisterView: View, WithRootNavigationController {
    
    // MARK: - Properties
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var showAlert = false
    @State private var registrationSuccess = false
    
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            if registrationSuccess {
                RegistrationCompletedView()
                Text("Your account has been successfully created!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 40)
                Button {
                    goToLogin()
                } label: {
                    Text("Continue")
                }
                .primaryButtonStyle
                
            } else {
                
                HStack(spacing: 12) {
                    Image(systemName: "person.badge.plus")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text("Create your Account")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 40)
                
                VStack(spacing: 12) {
                    CustomTextFieldStyleView(text: $registerViewModel.email, placeholder: "Enter your Email", iconName: "")
                        .onChange(of: registerViewModel.email, { oldValue, newValue in
                            registerViewModel.isEmailValid = Validator.validateEmail(email: newValue)
                        })
                    
                    SecureField("Password...", text: $registerViewModel.password)
                        .onChange(of: registerViewModel.password) { oldValue, newValue in
                            
                            registerViewModel.passwordStatus = Validator.validatePassword(password: newValue)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundColor(AppColors.black)
                        .padding(.horizontal, 16)
                        .background(AppColors.silver)
                        .cornerRadius(16)
                }
                .padding(.vertical, 10)
                
                // MARK: - Password chek
                VStack(alignment: .leading, spacing: 10) {
                    displayPasswordValidation(title: "Uppercase", conditation: registerViewModel.passwordStatus.containsUppercase)
                    
                    displayPasswordValidation(title: "Lowercase", conditation: registerViewModel.passwordStatus.containsLowercase)
                    
                    displayPasswordValidation(title: "Numbers", conditation: registerViewModel.passwordStatus.containsNumber)
                    
                    displayPasswordValidation(title: "Symbols(?#@...)", conditation: registerViewModel.passwordStatus.containsSymbol)
                    
                    displayPasswordValidation(title: "Min 8 characters", conditation: registerViewModel.passwordStatus.passwordLength)
                    
                }
                .foregroundColor(.red)
                .padding(.vertical, 40)
                
                // MARK: - Components
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
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundColor(AppColors.white)
                        .background(registerViewModel.isFormValid() ? AppColors.primary : AppColors.darkGray)
                        .cornerRadius(40)
                }
                
                .foregroundStyle(registerViewModel.isFormValid() ? AppColors.primary : AppColors.lightGray)
                .disabled(!registerViewModel.isFormValid())
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("The user with this email is already registered"), dismissButton: .default(Text("OK")))
                }
                
                Button {
                    goToLogin()
                } label: {
                    Text("Go to Login")
                }
                .secondaryButtonStyle
            }
            
            
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Methods
    func displayPasswordValidation(title: String, conditation: Bool) -> some View {
        Label(title, systemImage: conditation ? "checkmark.seal" : "x.square")
            .foregroundColor(conditation ? .green : .red)
    }
    
    func goToLogin() {
        self.push(viewController: UIHostingController(rootView: SignInView()), animated: true)
    }
}

// MARK: - Preview
#Preview {
    RegisterView()
}
