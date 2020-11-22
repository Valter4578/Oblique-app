//
//  Router.swift
//  Oblique
//
//  Created by Максим Алексеев on 26.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol Router {
    var assembly: AssemblyBuilder? { get set }
    var navigationController: UINavigationController? { get set }
    
    func initialViewController()
    func showAuth()
}

class AppRouter: Router {
    // MARK:- Properties
    var assembly: AssemblyBuilder?
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    
    // MARK:- Methods
    func initialViewController() {
        tabBarController = UITabBarController()
        
        if let tabBarController = tabBarController {
            // TODO:- add view controllers array
            guard let walletViewController = assembly?.configureWalletModule(router: self) else { return }
            tabBarController.viewControllers = [navigationFor(viewController: walletViewController)]
        }
    }
    
    func showAuth() {
        guard let authViewController = assembly?.configureAuthModule(router: self) else { return }
        
        tabBarController?.present(authViewController, animated: true, completion: nil)
    }
    
    // MARK:- Private functions
    private func navigationFor(viewController: UIViewController = UIViewController(), imageName: String? = nil) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    // MARK:- Inits
    init(assembly: AssemblyBuilder?) {
        self.assembly = assembly
    }
}
