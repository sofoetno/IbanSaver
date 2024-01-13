//
//  PersonAddView.swift
//  IbanSaver
//
//  Created by Levan Loladze on 12.01.24.
//

import SwiftUI
import VisionKit

struct PersonAddView: View {
    // MARK: - Properties
    @StateObject private var viewModel = PersonAddViewModel()
    var onSave: (PersonModel) -> Void
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image("male1")
                .resizable()
                .frame(width: 64, height: 64)
                .cornerRadius(6)
                .padding(.top, 100)
                .padding(.bottom, 50)
            
            VStack {
                CustomTextFieldWithIcon(text: $viewModel.fullName, placeholder: "Full Name", iconName: "")
                    .padding(.bottom, 12)
                CustomTextFieldWithClickableIconView(text: $viewModel.ibanNumber, placeholder: "IBAN number", iconName: "doc.viewfinder.fill") {
                    if DataScannerViewController.isSupported {
                        viewModel.liveScan.toggle()
                        print("Icon Clicked!")
                    } else {
                        print("not supported")
                    }
                }
                .padding(.bottom, 12)
                .listRowSeparator(.hidden)
                
                Picker("", selection: $viewModel.selectedBank) {
                    ForEach(bankSelect.allCases, id: \.self) { bank in
                        Text(bank.rawValue)
                    }
                }
                .frame(maxWidth: .infinity)
                .labelsHidden()
                .frame(height: 56)
                .background(AppColors.silver)
                .cornerRadius(16)
                .pickerStyle(.menu)
                .listRowSeparator(.hidden)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $viewModel.liveScan, content: {
                LiveTextFromCameraScan(liveScan: $viewModel.liveScan, scannedText: $viewModel.scannedText)
            })
            
            VStack {
                Button("Save") {
                    let newPerson = PersonModel(fullName: viewModel.fullName, avatarName: "male1", savedIbans: [IbanModel(ibanNumber: viewModel.scannedText, bankImage: viewModel.selectedBank)], isMale: true)
                    onSave(newPerson)
                }
                .primaryButtonStyle
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}



struct PersonAddView_Preview: PreviewProvider {
    static var previews: some View {
        let dummyOnSave: (PersonModel) -> Void = { person in
            print("Preview onSave called with person: \(person)")
        }
        
        return PersonAddView(onSave: dummyOnSave)
    }
}
