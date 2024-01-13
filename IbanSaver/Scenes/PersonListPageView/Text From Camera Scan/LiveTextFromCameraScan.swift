//
//  LiveTextFromCameraScan.swift
//  IbanSaver
//
//  Created by Levan Loladze on 12.01.24.
//

import SwiftUI

struct LiveTextFromCameraScan: View {
    @Environment(\.dismiss) var dismiss
    @Binding var liveScan: Bool
    @Binding var scannedText: String
    var body: some View {
        NavigationStack {
            VStack {
                DataScanerVC(scannedText: $scannedText, liveScan: $liveScan)
                Text("Capture Text")
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Capture Text")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LiveTextFromCameraScan(liveScan: .constant(false), scannedText: .constant(""))
}
