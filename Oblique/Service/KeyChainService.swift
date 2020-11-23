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
        var query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: email,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return }
    }
    
    func loadPassword(with email: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne ] as [String : Any]
        
        var dataReference: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataReference)
        if let result = dataReference as? NSDictionary, let passwordData = result[kSecValueData] as? Data {
            return String(decoding: passwordData, as: UTF8.self)
        }
        
        return nil
    }
}
