//
//  WithRootNavigationController.swift
//  IbanSaver
//
//  Created by Sofo Machurishvili on 10.01.24.
//

import UIKit
import SwiftUI

protocol WithRootNavigationController {
    // MARK: - Properties
    var rootNavigationController: UINavigationController? { get }
    
    // MARK: - Methods
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)

}

extension WithRootNavigationController where Self:View {
    
    // MARK: - Properties
    var rootNavigationController: UINavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let rootNavigationController = sceneDelegate.windows.first?.rootViewController
                as? UINavigationController else { return nil }
        
        return rootNavigationController
    }
    
    // MARK: - Methods
    func push(viewController: UIViewController, animated: Bool) {
        rootNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        rootNavigationController?.popViewController(animated: animated)
    }

}
