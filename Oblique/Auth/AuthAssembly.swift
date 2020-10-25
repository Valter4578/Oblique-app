//
//  AuthAssembly.swift
//  Oblique
//
//  Created by Максим Алексеев on 25.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class AuthAssembly {
    class func configureAuthModule() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.networkService = NetworkService()
        return viewController
    }
}
