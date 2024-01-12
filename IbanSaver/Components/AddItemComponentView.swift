//
//  AddItemComponentView.swift
//  IbanSaver
//
//  Created by Nika Jamatashvili on 12.01.24.
//

import SwiftUI

struct AddItemComponentView: View {
    
    //MARK: - Properties
    var avatarName: String
    @State private var fullName: String = ""
    @State private var iBanNumber: String = ""
    var selectedBank: String
    var isAddPersonView: Bool
    
    //MARK: - Body
    var body: some View {
        contentView
    }
    
    //MARK: - Components
    private var contentView: some View {
        VStack(spacing: 40) {
            settedInfoView
            inputInfoView
        }
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .padding(.bottom, 120)
        .background(AppColors.white)
    }
    
    private var settedInfoView: some View {
        VStack(spacing: 12) {
            avatarView
            titleView
        }
    }
    
    private var inputInfoView: some View {
        VStack(spacing: 40) {
            inputListView
            buttonView
        }
    }
    
    private var avatarView: some View {
        Image(avatarName)
            .resizable()
            .frame(width: 64, height: 64)
            .cornerRadius(6)
    }
    
    private var titleView: some View {
        Text(fullName)
            .font(.custom("Avenir Next Condensed", size: 24))
            .bold()
            .foregroundStyle(AppColors.black)
            .frame(height: 32)
    }
    
    private var inputListView: some View {
        VStack {
            if isAddPersonView {
                CustomTextFieldWithIcon(
                    text: $fullName,
                    placeholder: "Full Name",
                    iconName: ""
                )
            }
            
            CustomTextFieldWithIcon(
                text: $iBanNumber,
                placeholder: "iBan Number",
                iconName: "doc.viewfinder.fill"
            )
            
            bankSelectorView
        }
    }
    
    private var bankSelectorView: some View {
        Picker(selection: $iBanNumber, label: Text("Select Bank")) {
            Text("Bank of Georgia").tag(1)
            Text("TBC Bank").tag(2)
            Text("Credo Bank").tag(3)
            Text("Procredit Bank").tag(4)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(AppColors.silver)
        .cornerRadius(16)
        .pickerStyle(.menu)
    }
    
    private var buttonView: some View {
        Button("Save") {
        }
        .primaryButtonStyle
    }
}

//MARK: - Present
struct Present: View {
    @State private var fullName: String = ""
    var body: some View {
        VStack {
            AddItemComponentView(
                avatarName: "male3",
                selectedBank: "Credo",
                isAddPersonView: true
            )
        }
    }
}

#Preview {
    Present()
}
