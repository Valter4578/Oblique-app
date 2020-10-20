//
//  AuthViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK:- Properties
    
    // MARK:- Lifecycle
    override func loadView() {
        let authView = AuthView()
        authView.configureViews()
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK:- Configure
//    private func configureSignButton() {
//        view.addSubview(signButton)
//        signButton.snp.makeConstraints {
//            $0.leading.equalTo(view).offset(20)
//            $0.trailing.equalTo(view).offset(20)
//            $0.height.equalTo(53)
//        }
//    }
//
//    private func configureSignOption() {
//        view.addSubview(signOptionButton)
//
//        signOptionButton.snp.makeConstraints {
//            $0.bottom.equalTo(view).offset(50)
//            $0.trailing
//        }
//    }
}


