//
//  OnboardingView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - Properties
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentPage = 0
    var lastPage = OBData.count - 1
    var firstPage = 0
    @Namespace var namespace
    
    //MARK: - Body
    var body: some View {
        ZStack {
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(OBData) { item in
                        ItemView(item: item)
                            .frame(width: screenWidth)
                    }
                }
                .offset(x: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            onChanged(value: value)
                        })
                        .onEnded({ value in
                            onEnded(value: value)
                        })
                )
            }
            
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    HStack(spacing: 6) {
                        ForEach(0..<OBData.count) { i in
                            if i == currentPage {
                                Capsule()
                                    .matchedGeometryEffect(id: "page", in: namespace)
                                    .frame(width: 18, height: 6)
                                    .animation(.default)
                            } else {
                                Circle()
                                    .frame(width: 6, height: 6)
                            }
                        }
                    }
                    .foregroundColor(AppColors.primary)
                }
                
                ZStack {
                    if currentPage != lastPage {
                        HStack {
                            Button(action: {
                                currentPage = lastPage
                                withAnimation{xOffset = -screenWidth * CGFloat(currentPage)}
                            }, label: {
                                Text("Skip")
                                    .frame(width: 60)
                            })
                            Spacer()
                            
                            Button(action: {
                                currentPage += 1
                                withAnimation{xOffset = -screenWidth * CGFloat(currentPage)}
                            }, label: {
                                Text("Next")
                                    .frame(width: 60)
                                
                            })
                        }
                        .frame(height: 60)
                        .foregroundColor(AppColors.darkGray)
                    } else {
                        Button(action: {
                            UserDefaults.standard.set(true, forKey: "has-seen-onboarding")
                        }, label: {
                            Text("Get Started")
                                .foregroundStyle(AppColors.white)
                                .fontWeight(.semibold)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(Capsule().fill(AppColors.primary))
                        })
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    //MARK: - Methods
    func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentPage))
    }
    
    func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2 && currentPage < lastPage {
            currentPage += 1
        } else {
            if value.translation.width > screenWidth / 2 && currentPage > firstPage {
                currentPage -= 1
            }
        }
        withAnimation{
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

    //MARK: - Preview
#Preview {
    OnboardingView()
}

    //MARK: - ItemView
struct ItemView: View {
    
    //MARK: - Properties
    var item: OnboardingItem
    
    //MARK: - Body
    var body: some View {
        ZStack {
            item.OBBGColor
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .leading, spacing: 24) {
                Image(item.OBImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.OBTitle)
                        .font(.system(size: 24, weight: .semibold))
                        .animation(Animation.easeOut)
                    Text(item.OBSubtitle)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(AppColors.darkGray)
                        .animation(Animation.easeOut)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}
