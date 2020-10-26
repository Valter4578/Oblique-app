//
//  AuthPresenter.swift
//  Oblique
//
//  Created by Максим Алексеев on 25.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class AuthPresenter {
    // MARK:- Dependencies
    var view: AuthViewController! 
    var networkService: NetworkService!
    
    // MARK:- Properties
    
    // MARK:- Methods
    func signUp(email: String, password: String, confirmPass: String, name: String) {
        guard validateField(email: email, password: password, confirmPass: confirmPass) else { return }
        
        networkService.signUp(email: email, password: password, name: name) { result in
            switch result {
            case .failure(let _):
                self.view.didAuthentificate(token: nil)
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "token")
                self.view.didAuthentificate(token: token)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        guard validateField(email: email, password: password) else { return }
        
        networkService.signIn(email: email, password: password) { result in
            switch result {
            case .failure(let _):
                self.view.didAuthentificate(token: nil)
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "token")
                self.view.didAuthentificate(token: token)
            }
        }
    }
    
    // MARK:- Private methods
    private func validateField(email: String, password: String, confirmPass: String? = nil) -> Bool {
        // Validate email adress
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else { return false }
        
        // check if passwords are equal
        if let confirmPassword = confirmPass {
            guard password == confirmPass else { return false }
        }
        
        return true
    }
}
