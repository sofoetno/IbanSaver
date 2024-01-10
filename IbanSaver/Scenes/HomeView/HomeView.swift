//
//  ContentView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import SwiftUI

struct HomeView: View, WithRootNavigationController {
    
    // MARK: - Body
    var body: some View {
        Button {
            goToRegister()
        } label: {
            Text("Sign up")
        }
    }
    
    // MARK: - Methods
    func goToRegister() {
        self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

