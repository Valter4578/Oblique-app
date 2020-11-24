//
//  WalletPresenter.swift
//  Oblique
//
//  Created by Максим Алексеев on 04.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

protocol WalletInput {
    var networkService: NetService! { get }
    var wallets: [Wallet]? { get set }
    
    func getWallets(completionHandler: @escaping ([Wallet]) -> Void)
}

class WalletPresenter: WalletInput {
    // MARK:- Dependencies
    weak var view: WalletViewController!
    var networkService: NetService!

    var router: Router! 
    // MARK:- Properties
    var wallets: [Wallet]?
    
    // MARK:- Methods
    func getWallets(completionHandler: @escaping ([Wallet]) -> Void) {
        networkService.getWallets { result in
            switch result {
            case .success(let wallets):
                self.wallets = wallets
                completionHandler(wallets)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    // MARK:- Private methods
    
}
