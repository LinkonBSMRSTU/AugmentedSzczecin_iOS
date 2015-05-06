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
        
        let username = "Jonasz"
        let password = "QWERTY"
        
        credentialManagerForTests.storeCredential(username, password: password)
        
        XCTAssertEqual(username, userDefaultsForTests.stringForKey(credentialManagerForTests.usernameKey)!)
        XCTAssertEqual(password, userDefaultsForTests.stringForKey(credentialManagerForTests.passwordKey)!)
        
    }
    
    func testGetCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "Jonasz"
        let password = "QWERTY"
        
        userDefaultsForTests.setObject(username, forKey: credentialManagerForTests.usernameKey)
        userDefaultsForTests.setObject(password, forKey: credentialManagerForTests.passwordKey)
        userDefaultsForTests.synchronize()
        
        if let (getUsername, getPassword) = credentialManagerForTests.getCredentials() {
            XCTAssertEqual(username, getUsername)
            XCTAssertEqual(password, getPassword)
        } else {
            XCTFail("")
        }
        
    }
    
    func testClearCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "Jonasz"
        let password = "QWERTY"
        
        userDefaultsForTests.setObject(username, forKey: credentialManagerForTests.usernameKey)
        userDefaultsForTests.setObject(password, forKey: credentialManagerForTests.passwordKey)
        userDefaultsForTests.synchronize()
        
        credentialManagerForTests.clearCredentials()
        
        
        XCTAssertNil(userDefaultsForTests.stringForKey(credentialManagerForTests.usernameKey))
        XCTAssertNil(userDefaultsForTests.stringForKey(credentialManagerForTests.usernameKey))
        
        
    }
    
    func testDoesHaveCredentials() {
        
        credentialManagerForTests = createUniqueInstance()
        userDefaultsForTests = NSUserDefaults()
        credentialManagerForTests.userDefaults = userDefaultsForTests
        
        let username = "Jonasz"
        let password = "QWERTY"
        
        userDefaultsForTests.setObject(username, forKey: credentialManagerForTests.usernameKey)
        userDefaultsForTests.setObject(password, forKey: credentialManagerForTests.passwordKey)
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
