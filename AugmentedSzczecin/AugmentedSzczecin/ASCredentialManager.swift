//
//  ASCredentialManager.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 18.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation

class ASCredentialManager {
    
    private let userDefaults = NSUserDefaults()
    
    class var sharedInstance : ASCredentialManager {
        struct Static {
            static var instance: ASCredentialManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ASCredentialManager()
        }
        
        return Static.instance!
    }
    
    
    func hasCredentials() -> Bool {
        if let _ = getCredentials() {
            return true
        } else {
            return false
        }
    }
    
    
    func storeCredential(username: String!, password: String!) {
        userDefaults.setObject(username, forKey: "username")
        userDefaults.setObject(password, forKey: "password")
        userDefaults.synchronize()
    }
    
    func getCredentials() -> (String, String)? {
        let username = userDefaults.stringForKey("username")
        let password = userDefaults.stringForKey("password")
        if (username != nil || password != nil) {
            return (username!, password!)
        }
        return nil
    }
    
    func clearCredentials() {
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.synchronize()
    }
     
    
}
