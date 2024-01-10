//
//  ContentView.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import SwiftUI

struct HomeView: View, WithRootNavigationController {
    var body: some View {
        Button {
            goToRegister()
        } label: {
            Text("Sign up")
        }
    }
    
    func goToRegister() {
        self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
    }
}

#Preview {
    HomeView()
}

