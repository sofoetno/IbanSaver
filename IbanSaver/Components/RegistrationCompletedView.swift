//
//  RegistrationCompletedView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 12.01.24.
//

import SwiftUI

struct RegistrationCompletedView: View {
    @State private var scale: CGFloat = 1
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true), value: scale)
                .onAppear {
                    scale = 3
                }
            
            Text("Success")
                .foregroundColor(.green)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

// MARK: - Preview
#Preview {
    RegistrationCompletedView()
}
