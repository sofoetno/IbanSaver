//
//  ButtonExtension.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

extension Button {
    var primaryButtonStyle: some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .foregroundColor(AppColors.white)
            .background(AppColors.primary)
            .cornerRadius(40)
    }
    
    var secondaryButtonStyle: some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .foregroundColor(AppColors.primary)
            .background(AppColors.white)
            .cornerRadius(40)
    }
    var addButtonStyle: some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .foregroundColor(AppColors.white)
            .background(AppColors.white.opacity(0.04))
            .cornerRadius(40)
    }
}
