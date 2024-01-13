//
//  OnboardingViewModel.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 13.01.24.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var xOffset: CGFloat = 0
    @Published var currentPage = 0
    var lastPage: Int {
        OBData.count - 1
    }
    var firstPage: Int {
        0
    }

    //MARK: - Methods
    func onChanged(value: DragGesture.Value, screenWidth: CGFloat) {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentPage))
    }

    func onEnded(value: DragGesture.Value, screenWidth: CGFloat) {
        if -value.translation.width > screenWidth / 2 && currentPage < lastPage {
            currentPage += 1
        } else {
            if value.translation.width > screenWidth / 2 && currentPage > firstPage {
                currentPage -= 1
            }
        }
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}
