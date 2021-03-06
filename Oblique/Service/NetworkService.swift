//
//  NetworkService.swift
//  Oblique
//
//  Created by Максим Алексеев on 23.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    // MARK:- Properties
    let baseUrl = "http://localhost:8080"
    
    // MARK:- Methods
    func signIn(email: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let params = [
            "email": email,
            "password": password
        ]
        
        AF.request("\(baseUrl)/signin", method: .post, parameters: params)
            .responseJSON(completionHandler: { response in
                print(response)
                switch response.result {
                case .failure(let error):
                    print(error)
                    completionHandler(.failure(error))
                case .success(let value):
                    guard let jsonDict = value as? [String: Any],
                          let jwtToken = jsonDict["token"] as? String
                    else { return }
                    completionHandler(.success(jwtToken))
                }
            })
    }
    
    func signUp(email: String, password: String, name: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let params = [
            "email": email,
            "password": password,
            "name": name
        ]
        
        AF.request("\(baseUrl)/signup", method: .post, parameters: params)
            .responseJSON { response in
                print(response)
                
                switch response.result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let value):
                    guard let jsonDict = value as? [String: Any],
                          let jwtToken = jsonDict["token"] as? String
                    else { return }
                    completionHandler(.success(jwtToken))
                }
        }
    }
}
