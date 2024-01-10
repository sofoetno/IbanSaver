//
//  WithRootNavigationController.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import UIKit
import SwiftUI

protocol WithRootNavigationController {
    var rootNavigationController: UINavigationController? { get }
    
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)

}

extension WithRootNavigationController where Self:View {
    var rootNavigationController: UINavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let rootNavigationController = sceneDelegate.windows.first?.rootViewController
                as? UINavigationController else { return nil }
        
        return rootNavigationController
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        rootNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        rootNavigationController?.popViewController(animated: animated)
    }
}
