//
//  ASPOITests.swift
//  AugmentedSzczecin
//
//  Created by Grzegorz Pawlowicz on 07.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class mockedCLPlacemark: CLPlacemark{
    override var name: String {
        get {
            return "Pałac Pod Globusem"
        }
    }
}

var placemarks = [mockedCLPlacemark()]

class mockedCLGeocoder: CLGeocoder{
    override func reverseGeocodeLocation(location: CLLocation!, completionHandler: CLGeocodeCompletionHandler!) -> (){
        completionHandler(placemarks, nil)
    }
}

class ASPOITests: XCTestCase {

    var mockedPOI:ASPOI?
    
    override func setUp() {
        super.setUp()
        
        var managedContext = ASData.sharedInstance.mainContext
        mockedPOI = ASPOI(managedObjectContext: managedContext)
        mockedPOI!.id = 69383
        mockedPOI!.name = "Pałac Pod Globusem"
        mockedPOI!.tag = "pl_otwarte_zabytki"
        mockedPOI!.latitude =  53.426098
        mockedPOI!.longitude = 14.554294
    }
    
    override func tearDown() {

        super.tearDown()
    }

    
    func testGetAddress() {
        
        let expectation = expectationWithDescription("Expected CLPlacemark")
        
        mockedPOI?.getAddress(mockedCLGeocoder(), completionHandler: { (address) -> Void in
            
            XCTAssertEqual(address!.name, "Pałac Pod Globusem", "name property shoud equal Pałac Pod Globusem")
            
            expectation.fulfill()
        })

        waitForExpectationsWithTimeout(10, handler: nil)
        
    }

}