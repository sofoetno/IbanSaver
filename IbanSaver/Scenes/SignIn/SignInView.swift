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

                CustomTextFieldWithIcon(text: $model.email, placeholder: "Email", iconName: "")
                
                CustomTextFieldWithIcon(text: $model.password, placeholder: "Password", iconName: "")
                
                Button(action: {
                    
                }, label: {
                    Text("Forgot Password?")
                        .fontWeight(.thin)
                        .padding()
                        .foregroundStyle(AppColors.darkGray)
                })
            }
            .padding(.vertical, 40)
            
            // MARK: - Sign In and Face ID Buttons
            VStack(spacing: 12) {
                
                Button(action: {
                    
                    model.signIn()
                    
                }, label: {
                    
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    
                })
                .primaryButtonStyle
                .alert(isPresented: $model.showAlert) {
                    Alert(title: Text("Important message"), message: Text(model.error), dismissButton: .default(Text("Got it!")))
                }
                .onChange(of: model.isActive) { oldValue, newValue in
                    if newValue == true {
                        self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
                        model.isActive = false
                    }
                }
                
                
                Button(action: {
                    // Handle Face ID action
                    
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
