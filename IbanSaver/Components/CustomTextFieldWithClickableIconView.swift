//
//  CustomTextFieldWithClickableIconView.swift
//  IbanSaver
//
//  Created by Levan Loladze on 13.01.24.
//

import SwiftUI

struct CustomTextFieldWithClickableIconView: View {
    @Binding var text: String
    var placeholder: String
    var iconName: String
    var iconAction: () -> Void
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
            
            Button(action: {
                iconAction()
            }) {
                Image(systemName: iconName)
                    .foregroundColor(AppColors.darkGray)
                    .font(.system(size: 24))
                    .padding(.leading, 12)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .foregroundColor(AppColors.black)
        .padding(.horizontal, 16)
        .background(AppColors.silver)
        .cornerRadius(16)
    }
}
