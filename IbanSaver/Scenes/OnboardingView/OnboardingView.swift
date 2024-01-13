//
//  OnboardingView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

struct OnboardingView: View, WithRootNavigationController {
    
    //MARK: - Properties
    @ObservedObject private var viewModel = OnboardingViewModel()
    var screenWidth = UIScreen.main.bounds.width
    @Namespace private var pageControlNamespace
    
    //MARK: - Body
    var body: some View {
        mainContainerView
    }
    
    //MARK: - Components
    private var mainContainerView: some View {
        ZStack {
            geometryReaderView
            bottomNavigationView
        }
    }
    
    private var geometryReaderView: some View {
        GeometryReader { reader in
            HStack(spacing: 0) {
                ForEach(OBData) { item in
                    OnboardingItemView(item: item)
                        .frame(width: screenWidth)
                }
            }
            .offset(x: viewModel.xOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        viewModel.onChanged(value: value, screenWidth: screenWidth)
                    })
                    .onEnded({ value in
                        viewModel.onEnded(value: value, screenWidth: screenWidth)
                    })
            )
        }
    }
    
    private var bottomNavigationView: some View {
        VStack(spacing: 20) {
            Spacer()
            PageControlView(currentPage: $viewModel.currentPage, pageCount: OBData.count, namespace: pageControlNamespace)
            
            buttonsStackView
        }
    }
    
    private var buttonsStackView: some View {
        ZStack {
            if viewModel.currentPage != viewModel.lastPage {
                HStack {
                    skipButtonView
                    Spacer()
                    nextButtonView
                }
                .frame(height: 60)
                .foregroundColor(AppColors.darkGray)
            } else {
                getStartedButtonView
            }
        }
        .padding(.horizontal)
    }
    
    private var skipButtonView: some View {
        Button(action: {
            viewModel.currentPage = viewModel.lastPage
            withAnimation {
                viewModel.xOffset = -screenWidth * CGFloat(viewModel.currentPage)
            }
        }, label: {
            Text("Skip")
                .frame(width: 60)
        })
    }
    
    private var nextButtonView: some View {
        Button(action: {
            viewModel.currentPage += 1
            withAnimation {
                viewModel.xOffset = -screenWidth * CGFloat(viewModel.currentPage)
            }
        }, label: {
            Text("Next")
                .frame(width: 60)
        })
    }
    
    private var getStartedButtonView: some View {
        Button(action: {
            UserDefaults.standard.set(true, forKey: "has-seen-onboarding")
            self.push(viewController: UIHostingController(rootView: HomeView()), animated: true)
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

//MARK: - Preview
#Preview {
    OnboardingView()
}
