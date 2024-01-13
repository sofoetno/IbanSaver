//
//  PersonAddView.swift
//  IbanSaver
//
//  Created by Levan Loladze on 12.01.24.
//

import SwiftUI
import VisionKit

struct PersonAddView: View {
    
    @State private var fullName: String = ""
    @State private var ibanNumber: String = ""
    @State private var selectedBank: bankSelect = .Bog
    @State private var imageTaken: UIImage?
    @State private var recognizedTexts = [String]()
    @State private var liveScan = false
    @State private var scannedText = ""
    
    var onSave: (PersonModel) -> Void
    
    var body: some View {
        VStack {
            
            Image("male1")
                .resizable()
                .frame(width: 64, height: 64)
                .cornerRadius(6)
                .padding(.bottom, 50)
            
            VStack {
                CustomTextFieldWithIcon(text: $fullName, placeholder: "Full Name", iconName: "")
                    .padding(.bottom, 12)
                CustomTextFieldWithClickableIconView(text: $ibanNumber, placeholder: "IBAN number", iconName: "doc.viewfinder.fill") {
                    if DataScannerViewController.isSupported {
                        liveScan.toggle()
                        print("Icon Clicked!")
                    } else {
                        print("not supported")
                    }
                }
                .padding(.bottom, 12)
                .listRowSeparator(.hidden)
                
                Picker("", selection: $selectedBank) {
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
            .sheet(isPresented: $liveScan, content: {
                LiveTextFromCameraScan(liveScan: $liveScan, scannedText: $scannedText)
            })
            
            VStack {
                Button("Save") {
                    let newPerson = PersonModel(fullName: fullName, avatarName: "male1", savedIbans: [IbanModel(ibanNumber: scannedText, bankImage: selectedBank)], isMale: true)
                    onSave(newPerson)
                }
                .primaryButtonStyle
            }
            .padding(.horizontal, 24)
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
