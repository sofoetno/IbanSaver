//
//  SignInView.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import SwiftUI
import UIKit

struct SignInView: View, WithRootNavigationController {
    
    // MARK: - Properties
    @StateObject var model = SignInViewModel()
    
    // MARK: - Body
    var body: some View {
        
        // MARK: - Header
        VStack {
            
            Label(
                title: {
                    
                    Text("Login")
                        .fontWeight(.bold)
                    
                },
                icon: {
                    
                    Image(systemName: "person.badge.shield.checkmark")
                    
                }
            )
            .font(.system(size: 30))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .foregroundStyle(.primary)
            .padding(40)
            
            // MARK: - Text Fields and Forgot Password
            VStack(spacing: 12) {
                
                CustomTextFieldStyleView(text: $model.email, placeholder: "Email", iconName: "")
                
                CustomSecureFieldWithIcon(text: $model.password, placeholder: "Password", iconName: "")
                
                Button(action: {
                    model.forgot()
                }, label: {
                    Text("Forgot Password?")
                        .fontWeight(.thin)
                        .padding()
                        .foregroundStyle(AppColors.darkGray)
                })
                .alert(isPresented: $model.forgotAlert) {
                    switch model.forgotType {
                    case .fail:
                        Alert(title: Text("Password Reset"), message: Text(model.forgotResponse), dismissButton: .default(Text("OK")))
                    case .success:
                        Alert(title: Text("Password Reset"), message: Text(model.forgotResponse), dismissButton: .default(Text("OK")))
                    case .none:
                        Alert(title: Text("Password Reset"), message: Text(model.error), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding(.vertical, 40)
            
            // MARK: - Sign In and Face ID Buttons
            VStack(spacing: 12) {
                
                Button(action: {
                    
                    model.signIn(email: model.email, password: model.password)
                    
                }, label: {
                    
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    
                })
                .primaryButtonStyle
                .alert(isPresented: $model.showAlert) {
                    switch model.alertType {
                    case.mainAlert:
                        Alert(title: Text("Important message"), message: Text(model.error), dismissButton: .default(Text("OK")))
                    case.IDAlert:
                        Alert(title: Text("Face ID Message"), message: Text("Do you want to save Face ID?"),
                              primaryButton: .default(Text("Yes")) {
                            model.writeID()
                        },
                              secondaryButton: .default(Text("No")))
                    case.IDFail:
                        Alert(title: Text("Face ID"), message: Text("Face ID is not set up, please sign in first."), dismissButton: .default(Text("OK")))
                    case .none:
                        Alert(title: Text("NONE Message"), message: Text(model.error), dismissButton: .default(Text("OK")))
                    }
                }
                .onChange(of: model.isActive) { oldValue, newValue in
                    if newValue == true {
                        self.push(viewController:  PersonListPageViewController(), animated: true)
                        model.isActive = false
                    }
                }
                
                Button(action: {
                    
                    self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
                    
                }, label: {
                    
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    
                })
                .primaryButtonStyle
                
                
                Button(action: {
                    // Handle Face ID action
                    model.faceID()
                    
                }, label: {
                    
                    HStack {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColors.primary, lineWidth: 1)
                            .frame(width: 54, height: 54)
                            .overlay(
                                Image(systemName: "faceid")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            )
                    }
                })
                .secondaryButtonStyle
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(AppColors.white)
    }
}

#Preview {
    SignInView()
}
