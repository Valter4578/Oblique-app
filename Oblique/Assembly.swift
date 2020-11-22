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
    func configureWalletModule(router: Router) -> WalletViewController
}

class Assembly: AssemblyBuilder {
    func configureAuthModule(router: Router?) -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.networkService = NetworkService()
        return viewController
    }
    
    func configureWalletModule(router: Router) -> WalletViewController {
        let viewController = WalletViewController()
        let presenter = WalletPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.networkService = NetworkService()
        return viewController
    }
}
