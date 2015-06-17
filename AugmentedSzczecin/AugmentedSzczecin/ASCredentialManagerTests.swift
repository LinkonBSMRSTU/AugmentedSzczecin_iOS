//
//  ASCredentialManagerTests.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 05.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class ASCredentialManagerTests: XCTestCase {
    
    var credentialManagerForTests: ASCredentialManagerForTests!
    var userDefaultsForTests: NSUserDefaults!
    
    class ASCredentialManagerForTests: ASCredentialManager {}
    
    func getSharedInstance() -> ASCredentialManager {
        
        return ASCredentialManager.sharedInstance
    }
    
    func createUniqueInstance() -> ASCredentialManagerForTests {
        return ASCredentialManagerForTests()
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        //After each test the application's persistent domain should be removed so that the values don't remain in the chache
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        
        super.tearDown()
    }
    
    func testSingletonSharedInstanceCreated() {
        XCTAssertNotNil(getSharedInstance())
    }
    
    func testSingletonUniqueInstanceCreated() {
        XCTAssertNotNil(createUniqueInstance())
    }
    
    func testSingletonReturnsSameSharedInstanceTwice() {
        XCTAssert(getSharedInstance() === getSharedInstance())
    }
    
    func testSingletonSharedInstanceSeparateFromUniqueInstance() {
        XCTAssertFalse(getSharedInstance() === createUniqueInstance())
    }
    
    func testSingletonReturnsSeparateUniqueInstances() {
        XCTAssertFalse(createUniqueInstance() === createUniqueInstance())
    }
    
    func testStoreCredential() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "tbilski@wi.zut.edu.pl"
        let password = "QWERTY"
        
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        
        credentialManagerForTests.storeCredential(base64EncodedCredential)
        
        XCTAssertEqual(base64EncodedCredential, userDefaultsForTests.stringForKey(credentialManagerForTests.key)!)
        
    }
    
    func testGetCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "tbilski@wi.zut.edu.pl"
        let password = "QWERTY"
        
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        
        userDefaultsForTests.setObject(base64EncodedCredential, forKey: credentialManagerForTests.key)
        userDefaultsForTests.synchronize()
        
        if let (getHashedCredentials) = credentialManagerForTests.getCredentials() {
            XCTAssertEqual(base64EncodedCredential, getHashedCredentials)
        } else {
            XCTFail("")
        }
        
    }
    
    func testClearCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "tbilski@wi.zut.edu.pl"
        let password = "QWERTY"
        
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        
        userDefaultsForTests.setObject(base64EncodedCredential, forKey: credentialManagerForTests.key)
        userDefaultsForTests.synchronize()
        
        credentialManagerForTests.clearCredentials()
        
        XCTAssertNil(userDefaultsForTests.stringForKey(credentialManagerForTests.key))
        
        
    }
    
    func testDoesHaveCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "tbilski@wi.zut.edu.pl"
        let password = "QWERTY"
        
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        
        userDefaultsForTests.setObject(base64EncodedCredential, forKey: credentialManagerForTests.key)
        
        userDefaultsForTests.synchronize()
        
        XCTAssertTrue(credentialManagerForTests.hasCredentials(), "")
        
    }
    
    func testDoesNotHaveCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        XCTAssertFalse(credentialManagerForTests.hasCredentials(),"" )
    }
    
}
