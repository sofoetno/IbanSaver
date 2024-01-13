//
//  OnboardingItemView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 13.01.24.
//

import SwiftUI

struct OnboardingItemView: View {
    
    //MARK: - Properties
    var item: OnboardingItem
    
    //MARK: - Body
    var body: some View {
        mainContentView
    }
    
    private var mainContentView: some View {
        ZStack {
            item.OBBGColor
                .ignoresSafeArea(.all, edges: .all)
            contentWrapperView

        }
    }
    
    private var contentWrapperView: some View {
        VStack(alignment: .leading, spacing: 24) {
            onboardingImageView
            onboardingInfoView
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    
    private var onboardingImageView: some View {
        Image(item.OBImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.top)
    }
    
    private var onboardingInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.OBTitle)
                .font(.system(size: 24, weight: .semibold))
                .animation(Animation.easeOut)
            Text(item.OBSubtitle)
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(AppColors.darkGray)
                .animation(Animation.easeOut)
        }
    }
}

#Preview {
    OnboardingItemView(item: OnboardingItem(
        OBBGColor: AppColors.silver,
        OBImage: "OBInputImage",
        OBTitle: "Add New Person",
        OBSubtitle: "Enter the person's name, surname, and iBan number to start managing their financial details."
    ))
}
