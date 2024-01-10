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
            TextField("Enter your Email", text: $registerViewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $registerViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Repeat Password", text: $registerViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                registerViewModel.signUp()
            } label: {
                Text("Register")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        
    }
}

// MARK: - Preview
#Preview {
    RegisterView()
}
