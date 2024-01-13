//
//  PersonAddViewModel.swift
//  IbanSaver
//
//  Created by Levan Loladze on 13.01.24.
//

import SwiftUI

final class PersonAddViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var liveScan = false
    @Published var scannedText = ""
    @Published var fullName: String = ""
    @Published var ibanNumber: String = ""
    @Published var selectedBank: bankSelect = .Bog
    
}
