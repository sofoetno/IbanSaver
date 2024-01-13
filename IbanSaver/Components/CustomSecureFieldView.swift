//
//  SecureFieldStyleView.swift
//  IbanSaver
//
//  Created by David on 1/13/24.
//

import SwiftUI

struct CustomSecureFieldWithIcon: View {
    @Binding var text: String
    var placeholder: String
    var iconName: String
    
    var body: some View {
        HStack {
            SecureField(placeholder, text: $text)
            
            Image(systemName: iconName)
                .foregroundColor(AppColors.darkGray)
                .font(.system(size: 24))
                .padding(.leading, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .foregroundColor(AppColors.black)
        .padding(.horizontal, 16)
        .background(AppColors.silver)
        .cornerRadius(16)
    }
}
