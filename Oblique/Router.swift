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
    
    // MARK:- Methods
    func initialViewController() {
        // TODO:- add main view controller configuration
        
    }
    
    func showAuth() {
        let authViewController = assembly?.configureAuthModule(router: self)
        
    }
    
    // MARK:- Inits
    init(assembly: AssemblyBuilder?) {
        self.assembly = assembly
    }
}
