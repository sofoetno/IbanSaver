//
//  PageControlView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 13.01.24.
//

import SwiftUI

struct PageControlView: View {
    
    //MARK: - Properties
    @Binding var currentPage: Int
    let pageCount: Int
    let namespace: Namespace.ID
    
    //MARK: - Body
    var body: some View {
        pageControllerIndicatorView
    }
    
    //MARK: - Components
    private var pageControllerIndicatorView: some View {
        HStack(spacing: 6) {
            ForEach(0..<pageCount) { i in
                if i == currentPage {
                    Capsule()
                        .matchedGeometryEffect(id: "page", in: namespace)
                        .frame(width: 18, height: 6)
                        .animation(.default, value: currentPage)
                } else {
                    Circle()
                        .frame(width: 6, height: 6)
                }
            }
        }
        .foregroundColor(AppColors.primary)
    }
}
