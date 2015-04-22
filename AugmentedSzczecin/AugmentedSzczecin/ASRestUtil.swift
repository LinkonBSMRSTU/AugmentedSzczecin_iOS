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
    
    private let ascm: ASCredentialManager = ASCredentialManager.sharedInstance
    
    typealias APICallbackSuccess = (AnyObject? -> Void)
    typealias APICallbackFailure = ((Int?, String) -> Void)
    
    var path: Path!
    var callbackSuccess: APICallbackSuccess!
    var callbackFailure: APICallbackFailure!
    
    enum Path {
        
        static let baseURLString = "http://private-6c77f-patronage2015.apiary-mock.com/"
        
        case SIGNING_UP(String, String)
        
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
               
                }
                
            }
            
        }
        
    }
    
    
    func signUp(email: String, password: String, callbackSuccess: APICallbackSuccess, callbackFailure: APICallbackFailure) {
        
        makeHTTPRequest(Path.SIGNING_UP(email, password), callbackSuccess: callbackSuccess, callbackFailure: callbackFailure)
    }
    
    private func makeHTTPRequest(path: Path, callbackSuccess: APICallbackSuccess, callbackFailure: APICallbackFailure) {
        
        self.path = path
        self.callbackSuccess = callbackSuccess
        self.callbackFailure = callbackFailure
        
        let request = path.URLRequest
        
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
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
                
                if let parseJSON = json {
                    
                    switch (responseCode!, path) {
                    case (200, .SIGNING_UP(_, _)):
                        callbackSuccess(ASRestUtil.handleSignUp(parseJSON))
                    default:
                        callbackFailure(responseCode, NSHTTPURLResponse.localizedStringForStatusCode(responseCode!))
                    }
                } else {
                    callbackFailure(nil, "Could not parse JSON")
                }
                
            }
            
        })
        
        task.resume()
    }
    
    class func handleSignUp(json: AnyObject) -> ASUser? {
        if let userJson = json as? JSONDictionary {
            if let user = ASRestUtil.createUserFromJson(userJson) {
                        return user
            }
            return nil
        }
        return nil
    }
    
    class func createUserFromJson(userJson: Dictionary<String, AnyObject>) -> ASUser! {
        
        var user: ASUser = NSEntityDescription.insertNewObjectForEntityForName(ASUser.entityName(), inManagedObjectContext: ASData.sharedInstance.mainContext!) as! ASUser
        
        if let id = userJson["id"] as? Int {
            if let email = userJson["email"] as? String {
                if let password = userJson["password"] as? String {
                    user.password = password
                    user.email = email
                    user.id = id
                    return user
                    
                }
            }
        }
        return nil
    }
    
    class func paramsForSigningUp(email: String, password: String) -> (apiPath: String, parameters: Dictionary<String, String>) {
        
        let apiPath: String = "users"
        let parameters = ["email":email, "password":password]
        
        return (apiPath, parameters)
        
    }

}
