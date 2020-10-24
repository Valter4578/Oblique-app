//
//  AuthViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK:- Dependencies
    
    // MARK:- Properties
    
    // MARK:- Lifecycle
    override func loadView() {
        let authView = AuthView()
        authView.configureViews()
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func didPressSignButton() {
        
    }
}


