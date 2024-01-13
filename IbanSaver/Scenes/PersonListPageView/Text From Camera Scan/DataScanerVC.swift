//
//  DataScanerVC.swift
//  IbanSaver
//
//  Created by Levan Loladze on 12.01.24.
//

import Foundation
import VisionKit
import SwiftUI

struct DataScanerVC: UIViewControllerRepresentable {
    
    @Binding var scannedText: String
    @Binding var liveScan: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(recognizedDataTypes: [.text()], qualityLevel: .balanced, isHighlightingEnabled: true)
        
        viewController.delegate = context.coordinator
        return viewController
        
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if liveScan {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanerVC
        init(parent: DataScanerVC) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
                parent.liveScan = false
            default:
                break
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
