//
//  SignInView.swift
//  IbanSaver
//
//  Created by David on 1/11/24.
//

import SwiftUI
import UIKit

struct SignInView: View, WithRootNavigationController {
    
    @StateObject var model = SignInViewModel()
    
    var body: some View {
            
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundStyle(.purple)
                
                Group {
                    
                    CustomTextfield(text: $model.email, placeholder: "Email", image: "envelope")
                    
                    CustomTextfield(text: $model.password, placeholder: "Password", image: "key.viewfinder")
                    
                }
                .textFieldStyle(.plain)
                .padding(.vertical, 4)
                .multilineTextAlignment(.center)
                .padding(.trailing, 40)
                .foregroundStyle(.purple)
                
                Text("Forgot Password?")
                    .fontWeight(.thin)
                    .padding()
                    .foregroundStyle(.purple)
                
                Button(action: {
                    
                    model.signIn()
                    
                    if model.isActive {
                        self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
                    }
                    
                }, label: {
                    
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    
                })
                .buttonStyle(.bordered)
                .tint(.purple)
                
                
                
                Button(action: {
                    
                }, label: {
                    
                    Label("Face ID", systemImage: "faceid")
                        .labelStyle(.automatic)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fontWeight(.bold)
                    
                })
                .buttonStyle(.bordered)
                .tint(.purple)
            }
            .padding()
    }
}

#Preview {
    SignInView()
}

struct CustomTextfield: View {
    
    @Binding var text: String
    let placeholder: String
    let image: String
    
    var body: some View {
        
        HStack {
            
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            VStack {
                TextField(text: $text) {
                    
                    Text(placeholder)
                        .fontWeight(.ultraLight)
                    
                }
                
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundColor(.purple)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                
            }
        }
    }
}
