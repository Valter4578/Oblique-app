//
//  KeyChainService.swift
//  Oblique
//
//  Created by Максим Алексеев on 23.11.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class KeyChainService {
    func savePassword(for email: String, password: String) {
        let server = "localhost:8080"
        guard let password = password.data(using: String.Encoding.utf8) else { return }
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: email,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return }
    }
    
    func loadPassword(with email: String) -> String? {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: email,
            kSecReturnData: kCFBooleanTrue!] as CFDictionary
        
        var dataReference: CFTypeRef?
        let status: OSStatus = SecItemCopyMatching(query, &dataReference)
        
        guard status == errSecSuccess else { return nil }
        if let data = dataReference as? Data {
            return String(decoding: data, as: UTF8.self)
        }
        
        return nil
    }
}
