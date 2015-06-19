//
//  ASCredentialManager.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 18.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation

class ASCredentialManager {
    
    private(set) var key = "username:password"
    
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
    
    
    func storeCredential(credentials: NSString!) {
        
        let userPasswordData = credentials.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        
        self.userDefaults.setObject(base64EncodedCredential, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func getCredentials() -> String? {
        let hashedCredentials = self.userDefaults.stringForKey(key)
        
        if (hashedCredentials != nil) {
            return hashedCredentials!
        }
        return nil
    }
    
    func clearCredentials() {
        self.userDefaults.removeObjectForKey(key)
        self.userDefaults.synchronize()
    }
    
}
