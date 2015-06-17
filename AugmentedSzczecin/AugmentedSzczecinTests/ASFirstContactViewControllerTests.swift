//
//  ASFirstContactViewControllerTests.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 15.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class ASFirstContactViewControllerTests: XCTestCase {

    var vc: ASFirstContactViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("ASFirstContactViewController") as? ASFirstContactViewController
        vc!.loadView()
    }
    
    override func tearDown() {
        super.tearDown()
        vc = nil
    }

    func testVC() {
        XCTAssertNotNil(vc!, "VC is nil")
    }
    
    func testRegisterButton() {
        XCTAssertNotNil(vc!.registerButton, "Register button is nil")
    }
    
    func testRegisterButtonTap() {
        let responders: NSArray = vc!.registerButton.actionsForTarget(vc!, forControlEvent: UIControlEvents.TouchUpInside)!
        XCTAssertTrue(responders.containsObject("showRegistrationViewController:"), "Register button has no actions")
    }
    
    func testRegisterSegue() {
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        vc!.performSegueWithIdentifier("ShowRegistration", sender: nil)
        XCTAssertNotNil(vc!.presentedViewController, "VC isn't presented")
    }
}
