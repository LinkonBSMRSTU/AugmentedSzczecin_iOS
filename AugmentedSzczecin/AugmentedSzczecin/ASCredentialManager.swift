//
//  ASCredentialManager.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 18.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation

class ASCredentialManager {
    
    private(set) var usernameKey = "username"
    private(set) var passwordKey = "password"
    
    var userDefaults: NSUserDefaults = {
        var temporaryUserDefauls: NSUserDefaults = NSUserDefaults()
        return temporaryUserDefauls
        }()
    
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
        self.userDefaults.setObject(username, forKey: usernameKey)
        self.userDefaults.setObject(password, forKey: passwordKey)
        self.userDefaults.synchronize()
    }
    
    func getCredentials() -> (String, String)? {
        let username = self.userDefaults.stringForKey(usernameKey)
        let password = self.userDefaults.stringForKey(passwordKey)
        if (username != nil || password != nil) {
            return (username!, password!)
        }
        return nil
    }
    
    func clearCredentials() {
        self.userDefaults.removeObjectForKey(usernameKey)
        self.userDefaults.removeObjectForKey(passwordKey)
        self.userDefaults.synchronize()
    }
    
}
