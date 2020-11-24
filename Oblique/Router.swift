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
    func showTabBar(animated: Bool)
    func dismissCurrent(animated: Bool) 
}

class AppRouter: Router {
    // MARK:- Properties
    var assembly: AssemblyBuilder?
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    var currentController: UIViewController?
    
    // MARK:- Methods
    func initialViewController() {
        let launchViewController = assembly?.configureLaunchModule(router: self)
        currentController = launchViewController
    }
    
    func showAuth() {
        guard let authViewController = assembly?.configureAuthModule(router: self) else { return }
        authViewController.modalPresentationStyle = .fullScreen
        currentController?.present(authViewController, animated: true, completion: nil)
    }
    
    func showLaunch() {
        
    }
    
    func showTabBar(animated: Bool) {
        if let tabBarController = tabBarController {
            guard let walletViewController = assembly?.configureWalletModule(router: self) else { return }
            tabBarController.viewControllers = [navigationFor(viewController: walletViewController)]
            tabBarController.modalPresentationStyle = .fullScreen
            currentController?.present(tabBarController, animated: true)
        }
    }
    
    func dismissCurrent(animated: Bool) {
        currentController?.dismiss(animated: animated)
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
