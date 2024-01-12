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
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Full Name", text: $fullName)
                HStack {
                    TextField("IBAN Number", text: $scannedText)
                    
                    if DataScannerViewController.isSupported {
                        Button(action: {
                            liveScan.toggle()
                            print("Icon Clicked!")
                        }) {
                            Image(systemName: "camera")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                        }
                    } else {
                        Image(systemName: "line.3.crossed.swirl.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    }
                }
            }
            
            Section(header: Text("Bank Selection")) {
                Picker("Select Bank", selection: $selectedBank) {
                    ForEach(bankSelect.allCases, id: \.self) { bank in
                        Text(bank.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Button("Save") {
                    print("Full Name: \(fullName)")
                    print("IBAN Number: \(scannedText)")
                    print("Selected Bank: \(selectedBank.rawValue)")
                    let newPerson = PersonModel(fullName: fullName, avatarName: "male1", savedIbans: [IbanModel(ibanNumber: scannedText, bankImage: selectedBank)], isMale: true)
                    onSave(newPerson)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            
        }
        .navigationBarTitle("Add Person", displayMode: .inline)
        .sheet(isPresented: $liveScan, content: {
            LiveTextFromCameraScan(liveScan: $liveScan, scannedText: $scannedText)
        })
    }
}

struct PersonAddView_Preview: PreviewProvider {
    static var previews: some View {
        // Create a dummy implementation of onSave for the preview
        let dummyOnSave: (PersonModel) -> Void = { person in
            // Dummy implementation
            print("Preview onSave called with person: \(person)")
        }
        
        return PersonAddView(onSave: dummyOnSave)
    }
}
