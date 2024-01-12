//
//  ListRowView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

struct ListRowView: View {
    
    //MARK: - Properties
    var image: String
    var textLabel: String
    var personView: Bool
    
    //MARK: - Body
    var body: some View {
        CellView
    }
    
    //MARK: - Components
    private var CellView: some View {
        return ZStack {
            HStack(spacing: 8) {
                avatarView
                titleView
                Spacer()
                conditionalActionView(canShow: personView)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.white.opacity(0.06))
                .frame(height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        AppColors.white.opacity(0.0),
                                        AppColors.white.opacity(0.20)
                                    ]
                                ),
                                startPoint: .topLeading,
                                endPoint: .center
                            ),
                            lineWidth: 0.4
                        )
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        AppColors.white.opacity(0.02),
                                        AppColors.white.opacity(0.12)
                                    ]
                                ),
                                startPoint: .top,
                                endPoint: .center
                            ),
                            lineWidth: 0.6
                        )
                )
        }
    }
    
    private var avatarView: some View {
        Image(image)
            .resizable()
            .foregroundStyle(.white)
            .frame(width: personView ? 40 : 32)
            .frame(height: personView ? 40 : 32)
            .cornerRadius(6)
    }
    
    private var titleView: some View {
        Text(textLabel)
            .font(Font.system(size: 14))
        
    }
    
    private var actionView: some View {
        HStack(spacing: 4) {
            iconView(iconName: "doc.on.doc.fill")
            iconView(iconName: "ellipsis.circle.fill")
        }
    }
    
    private func iconView(iconName: String) -> some View {
        Image(systemName: iconName)
            .foregroundColor(AppColors.white)
            .font(Font.system(size: 14))
            .frame(width: 20, height: 20)
            .padding(4)
            .background(AppColors.white.opacity(0.04))
            .cornerRadius(6)
    }
    
    private func conditionalActionView(canShow: Bool) -> some View {
        Group {
            if canShow {
                EmptyView()
            } else {
                actionView
            }
        }
    }
}

//MARK: - Preview
#Preview {
    VStack(spacing: 24) {
        Spacer()
        ListRowView(image: "BOG", textLabel: "GE00TB0000000000000000", personView: false)
        ListRowView(image: "male5", textLabel: "Joshua mantkava", personView: true)
        Spacer()
    }
    .frame(height: 400)
    .background(AppColors.primary)
}
