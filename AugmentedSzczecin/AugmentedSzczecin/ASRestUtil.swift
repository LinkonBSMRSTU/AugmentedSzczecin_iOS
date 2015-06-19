//
//  ASRestUtil.swift
//  AugmentedSzczecin
//
//  Created by Tomasz Bilski on 18.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONArray = Array<AnyObject>

class ASRestUtil {
    
    let credentialManager: ASCredentialManager = ASCredentialManager.sharedInstance
    
    typealias APICallbackSuccess = (AnyObject? -> Void)
    typealias APICallbackFailure = ((Int?, String) -> Void)
    
    var path: Path!
    var callbackSuccess: APICallbackSuccess!
    var callbackFailure: APICallbackFailure!
    
    enum Path {
        
        static let baseURLString = "http://private-6c77f-patronage2015.apiary-mock.com/"
        
        case SIGNING_UP(String, String)
        case GET_ALL_POIS
        
        var URLRequest: NSMutableURLRequest {
            get{
                switch self {
                case .SIGNING_UP(let email, let password):
                    
                    let (apiPath, parameters) = ASRestUtil.paramsForSigningUp(email, password: password)
                    var err: NSError?
                    let request = NSMutableURLRequest(URL: NSURL(string: Path.baseURLString + apiPath)!)
                    request.HTTPMethod = "POST"
                    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err)
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    return request
                case .GET_ALL_POIS:
                    
                    var err: NSError?
                    let request = NSMutableURLRequest(URL: NSURL(string: Path.baseURLString + "places")!)
                    request.HTTPMethod = "GET"
                    
                    let credentials = ASCredentialManager.sharedInstance.getCredentials()
                    
                    if credentials != nil {
                        
                        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
                        
                    }
                    
                    //Zrobic pobieranie dla niezarejstrowanego uzytkownika
                    
                    return request
                    
                    
                    
                }
                
            }
            
        }
        
        var parameters: (email: String?, password: String?) {
            get {
                switch self {
                case .SIGNING_UP(let email, let password):
                    return (email, password)
                default:
                    return (nil, nil)
                }
            }
        }
        
    }
    
    
    func signUp(email: String, password: String, callbackSuccess: APICallbackSuccess, callbackFailure: APICallbackFailure) {
        
        makeHTTPRequest(Path.SIGNING_UP(email, password), callbackSuccess: callbackSuccess, callbackFailure: callbackFailure)
    }
    
    func getAllPois(callbackSuccess: APICallbackSuccess, callbackFailure: APICallbackFailure) {
        
        makeHTTPRequest(Path.GET_ALL_POIS, callbackSuccess: callbackSuccess, callbackFailure: callbackFailure)
    }
    
    private func makeHTTPRequest(path: Path, callbackSuccess: APICallbackSuccess, callbackFailure: APICallbackFailure) {
        
        self.path = path
        self.callbackSuccess = callbackSuccess
        self.callbackFailure = callbackFailure
        
        let request = path.URLRequest
        
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var err: NSError?
            var json: AnyObject?
            
            switch (path) {
                
            case .GET_ALL_POIS:
                json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSArray
            case .SIGNING_UP(_, _):
                json = nil
                err = nil
                
            }
            var responseCode: Int?
            
            if response != nil {
                responseCode = (response as! NSHTTPURLResponse).statusCode
            } else {
                responseCode = nil
            }
            
            if (err != nil) {
                
                if responseCode != nil {
                    callbackFailure(responseCode, NSHTTPURLResponse.localizedStringForStatusCode(responseCode!))
                }
                else {
                    callbackFailure(nil, "Could not parse JSON. Connection error has occurred")
                }
                
            } else {
                
                if json != nil {
                    
                    switch (responseCode!, path) {
                    case (200, .GET_ALL_POIS):
                        callbackSuccess(ASRestUtil.handleGetAllPois(json!))
                    default:
                        callbackFailure(responseCode, NSHTTPURLResponse.localizedStringForStatusCode(responseCode!))
                    }
                } else {
                    
                    if responseCode != nil {
                        
                        switch (responseCode!, path) {
                        case (204, .SIGNING_UP(_,_)):
                            
                            let userPasswordString = NSString(format: "%@:%@",path.parameters.email!, path.parameters.password!)
                            
                            self.credentialManager.storeCredential(userPasswordString)
                            
                            callbackSuccess(nil)
                        default:
                            callbackFailure(responseCode, NSHTTPURLResponse.localizedStringForStatusCode(responseCode!))
                            //w kontrolerze komunikat o tym, ze uzytkownik o podanych danych istnieje juz w bazie
                        }
                    } else {
                        callbackFailure(nil, "Connection error has occurred")
                    }
                }
                
            }
            
        })
        
        task.resume()
    }
    
    //    class func handleSignUp(json: AnyObject) -> ASUser? {
    //        if let userJson = json as? JSONDictionary {
    //            if let user = ASRestUtil.createUserFromJson(userJson) {
    //                        return user
    //            }
    //            return nil
    //        }
    //        return nil
    //    }
    
    class func handleGetAllPois(json: AnyObject) -> Bool {
        if let listOfPoisJson = json as? NSArray {
            ASRestUtil.savePoisToDataBase(listOfPoisJson)
            return true
        }
        return false
    }
    
    class func createUserFromJson(userJson: Dictionary<String, AnyObject>) -> ASUser? {
        
        var user = ASUser(managedObjectContext: ASData.sharedInstance.mainContext)
        
        if let id = userJson["id"] as? Int, let email = userJson["email"] as? String, let password = userJson["password"] as? String {
            user.password = password
            user.email = email
            user.id = id
            return user
        }
        return nil
    }
    
    class func savePoisToDataBase(listOfPoisJson: NSArray) {
        let managedContext = ASData.sharedInstance.mainContext
        
        for iterator in listOfPoisJson {
            if let id = iterator["id"] as? String, let name = iterator["name"] as? String, let tag = iterator["description"] as? String, let location = iterator["location"]as? NSDictionary {
                
                var poi = ASPOI(managedObjectContext: managedContext)
                
                poi.id = id
                poi.name = name
                poi.tag = tag
                poi.latitude = location["latitude"] as? Double
                poi.longitude = location["longitude"] as? Double
            }
            managedContext?.save(nil)
        }
    }
    
    class func paramsForSigningUp(email: String, password: String) -> (apiPath: String, parameters: Dictionary<String, String>) {
        
        let apiPath: String = "users"
        let parameters = ["email":email, "password":password]
        
        return (apiPath, parameters)
        
    }
    
}
