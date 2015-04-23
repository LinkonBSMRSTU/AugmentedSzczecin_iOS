//
//  ASRestUtilTests.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 22.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class ASRestUtilTests: XCTestCase {
    
    let email = "tbilski@wi.zut.edu.pl"
    let password = "QWERTY"
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParamsForSigningUp() {
        
        let (expectedApiPath, expectedParameters) = ("users",["email":email, "password":password])
        let (apiPath, parameters) = ASRestUtil.paramsForSigningUp(email, password: password)
        
        XCTAssertEqual(apiPath, expectedApiPath, "The first element should be equal to expectedApiPath")
        XCTAssertEqual(parameters, expectedParameters, "The second element should be equal to expectedParameters")
        
    }
    
    func testRequestSigningUp() {
        
        let request = ASRestUtil.Path.SIGNING_UP(email, password)
        let correctBaseUrlString = "http://private-6c77f-patronage2015.apiary-mock.com/"
        let correctApiPath = "users"
        let correctAbsoluteUrlString = correctBaseUrlString + correctApiPath
        let correctHTTPMethod = "POST"
        
        let resultAbsoluteString = request.URLRequest.URL?.absoluteString
        let resultHTTPMethod = request.URLRequest.HTTPMethod
        
        XCTAssertEqual(resultAbsoluteString!, correctAbsoluteUrlString , "The correct query string should be: correctBaseUrlString + correctApiPath")
        
        XCTAssertEqual(resultHTTPMethod, correctHTTPMethod , "The HTTP method should be type of POST")
        
    }
    
    func testCreateUserFromJsonCorrect() {
        
        var params = ["id":12345,"email":"xxx", "password":"zzz"]
        var exampleJsonData = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        var exampleJsonDictionary = NSJSONSerialization.JSONObjectWithData(exampleJsonData!, options: .MutableLeaves, error: nil) as? NSDictionary

        let results = ASRestUtil.handleSignUp(exampleJsonDictionary!)

        XCTAssertEqual(results!.password!, params["password"] as! String, "")
        XCTAssertEqual(results!.email!, params["email"] as! String, "")
        XCTAssertEqual(results!.id!, params["id"] as! Int, "")
        
    }
    
    func testCreateUserFromJsonIncorrect() {
        
        var params = ["id":12345,"email":"xxx"]
        var exampleJsonData = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        var exampleJsonDictionary = NSJSONSerialization.JSONObjectWithData(exampleJsonData!, options: .MutableLeaves, error: nil) as? NSDictionary
        
        let results = ASRestUtil.handleSignUp(exampleJsonDictionary!)
        
        XCTAssertNil(results, "When data in json are incorrect, handleSingUp method should return nil")
        
    }
    
}
