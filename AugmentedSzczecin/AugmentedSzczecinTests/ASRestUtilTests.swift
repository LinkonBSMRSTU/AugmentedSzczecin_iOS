//
//  ASRestUtilTests.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 22.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest
import CoreData

class ASRestUtilTests: XCTestCase {
    
    let email = "tbilski@wi.zut.edu.pl"
    let password = "QWERTY"
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        // After testSavingListOfPoistoDatabase() is called, the added data should be entirely removed from the database
        
        let managedContext = ASData.sharedInstance.mainContext
        
        var request = NSFetchRequest(entityName: ASPOI.entityName())
        
        var data = managedContext?.executeFetchRequest(request, error: nil)
        
        if let dataToDelete = data as? [NSManagedObject] {
            
            for element in dataToDelete {
                managedContext?.deleteObject(element)
                managedContext?.save(nil)
            }
            
        }
        
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
        
        var params = ["id":12345,"email":"xxx"] //incorrect data
        var exampleJsonData = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        var exampleJsonDictionary = NSJSONSerialization.JSONObjectWithData(exampleJsonData!, options: .MutableLeaves, error: nil) as? NSDictionary
        
        let results = ASRestUtil.handleSignUp(exampleJsonDictionary!)
        
        XCTAssertNil(results, "When data in json are incorrect, handleSingUp method should return nil")
        
    }
    
    func testSavingListOfPoistoDatabase() {
        
        let paramsExample: Array<Dictionary<String,AnyObject>> = [
            [
            
                "id":69383,
                "name": "Pałac Pod Globusem",
                "tag": "pl_otwarte_zabytki",
                "location": [
                    "latitude": 53.426098,
                    "longitude": 14.554294
                ]
            ],
            [
                
                "id":69390,
                "name": "Kamienica, ob. poczta",
                "tag": "pl_otwarte_zabytki",
                "location": [
                    "latitude": 53.428388,
                    "longitude": 14.536905
                ]
            ],
            [
                
                "id":45637,
                "name": "JakasNazwa1",
                "tag": "JakisTag1",
                "location": [
                    "latitude": 43.737787,
                    "longitude": 14.678678
                ]
            ],
            [
                
                "id":29999,
                "name": "JakasNazwa2",
                "tag": "JakisTag2",
                "location": [
                    "latitude": 23.010823,
                    "longitude": 78.283947
                ]
            ],
            [
                
                "id":22222,
                "name": "JakasNazwa3",
                "tag": "JakisTag3",
                "location": [
                    "latitude": 45.787777,
                    "longitude": 13.899777
                ]
            ]
            
        ]
        
        var exampleJsonData = NSJSONSerialization.dataWithJSONObject(paramsExample, options: nil, error: nil)
        var exampleJsonDictionary = NSJSONSerialization.JSONObjectWithData(exampleJsonData!, options: .MutableContainers, error: nil) as? NSArray

        
        func getContext() -> NSManagedObjectContext? {
            
            let managedContext = ASData.sharedInstance.mainContext
            
            return managedContext
            
        }
        
        func getObjects(predicate: NSPredicate?) -> [AnyObject]? {
            
            var request = NSFetchRequest(entityName: ASPOI.entityName())
            
            if(predicate != nil) {
                request.predicate = predicate
            }
            
            var data = getContext()?.executeFetchRequest(request, error: nil)
            
            return data
            
        }
        
        func deleteObjects() {
            
            if let data = getObjects(nil) {
                for element in data {
                    getContext()?.deleteObject(element as! NSManagedObject)
                    getContext()?.save(nil)
                }
            }
            
        }
        
        func countObjectsInDatabase() -> (count: Int, error: NSError?)  {
            
            var request = NSFetchRequest(entityName: ASPOI.entityName())
            var _error: NSError?
            
            return (count: ASData.sharedInstance.mainContext!.countForFetchRequest(request, error: &_error), error: _error)
            
        }
        
        deleteObjects()
        ASRestUtil.savePoisToDataBase(exampleJsonDictionary!) //saving data to the database
        
        var areDataSavedInDatabase: Bool {
            get {
                if (countObjectsInDatabase().error == nil) {
                    if countObjectsInDatabase().count == paramsExample.count {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        
        XCTAssertTrue(areDataSavedInDatabase, "The list of POIs should be saved in database and have the same number of elements as paramsExample")
        
        if (areDataSavedInDatabase) {
            for element in paramsExample {
                var id = element["id"] as! Int
                let predicate = NSPredicate(format: "id == %ld", id)
                if let data = getObjects(predicate) as? [NSManagedObject] {
                    if (data.count == 1) {
                        var fetchedObject = data[0]
                        
                        XCTAssertEqual(fetchedObject.valueForKeyPath(ASPOIAttributes.id.rawValue) as! Int, element["id"] as! Int, "")
                        XCTAssertEqual(fetchedObject.valueForKeyPath(ASPOIAttributes.name.rawValue) as! String, element["name"] as! String, "")
                        XCTAssertEqual(fetchedObject.valueForKeyPath(ASPOIAttributes.tag.rawValue) as! String, element["tag"] as! String, "")
                        
                        let location = element["location"] as! Dictionary<String,AnyObject>
                        
                        XCTAssertEqualWithAccuracy(fetchedObject.valueForKeyPath(ASPOIAttributes.latitude.rawValue) as! Double, location["latitude"] as! Double, 0.0001, "")
                        XCTAssertEqualWithAccuracy(fetchedObject.valueForKeyPath(ASPOIAttributes.longitude.rawValue) as! Double, location["longitude"] as! Double, 0.0001, "")
                        
                    } else {
                        XCTFail("Should be only one element that has the given id. Number of found elements: \(data.count)")
                    }
                
                } else {
                    
                    XCTFail("Error has occurred. executeFetchRequest returned nil")

                }
                
                
            }
            
        }
        
    }
}
