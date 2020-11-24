//
//  Assembly.swift
//  Oblique
//
//  Created by Максим Алексеев on 26.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol AssemblyBuilder {
    func configureAuthModule(router: Router?) -> AuthViewController
    func configureWalletModule(router: Router?) -> WalletViewController
    func configureLaunchModule(router: Router?) -> LaunchViewController 
}

class Assembly: AssemblyBuilder {
    func configureAuthModule(router: Router?) -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.networkService = NetworkService()
        presenter.router = router
        return viewController
    }
    
    func configureWalletModule(router: Router?) -> WalletViewController {
        let viewController = WalletViewController()
        let presenter = WalletPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.networkService = NetworkService()
        presenter.router = router
        return viewController
    }
    
    func configureLaunchModule(router: Router?) -> LaunchViewController {
        let viewController = LaunchViewController()
        let presenter = LaunchPresenter()
        viewController.presenter = presenter
        presenter.view  = viewController
        presenter.networkService = NetworkService()
        presenter.keyChainService = KeyChainService()
        presenter.router = router
        return viewController
    }
}
