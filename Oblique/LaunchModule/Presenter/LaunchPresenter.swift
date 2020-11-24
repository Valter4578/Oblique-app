//
//  LaunchPresenter.swift
//  Oblique
//
//  Created by Максим Алексеев on 23.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol LaunchInput {
    func logIn()
}

class LaunchPresenter: LaunchInput {
    // MARK:- Dependencies
    weak var view: LaunchViewController!
    var keyChainService: KeyChainService!
    var networkService: NetService!
    
    var router: Router!
    // MARL:- Properties
    
    // MARK:- Private methods
    
    // MARK:- Methods
    func logIn() {
        // get email from ud
        guard let email = UserDefaults.standard.string(forKey: "email"),
            let password = keyChainService.loadPassword(with: email)
            else {
                self.router.showAuth()
                return
        }
        networkService.signIn(email: email, password: password) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "token")
                self.router.showTabBar(animated: false)
            case .failure(let error):
                print(error.localizedDescription)
                self.router.showAuth()
                return
            }
        }
        
    }
}
