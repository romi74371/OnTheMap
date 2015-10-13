//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 20/09/15.
//  Copyright (c) 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Convenient Resource Methods

extension UdacityClient {
    
    // MARK: - Authentication (GET) Methods

    func authenticate(userName: String, password: String, completionHandler: (success: Bool, firstName: String, lastName: String, errorString: String?) -> Void) {

        self.getUserID(userName, password: password) { (success, userID, errorString) in
            if success {
                self.getUserData(userID) { (success, fistName, lastName, errorString) in
                    if success {
                        completionHandler(success: success, firstName: fistName!, lastName: lastName!, errorString: errorString)
                    }
                }
            } else {
                completionHandler(success: success, firstName: "", lastName: "", errorString: errorString?.localizedDescription)
            }
        }
    }
    
    func getUserData(userID: String?, completionHandler: (success: Bool, firstName: String?, lastName: String?, errorString: String?) -> Void) {
        
        let method : String = Methods.Users + "/" + userID!
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters = [String: AnyObject]()
        
        /* 2. Make the request */
        taskForGETMethod(method, parameters: parameters) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, firstName: nil, lastName: nil, errorString: "Login Failed (Session ID).")
            } else {
                var user = JSONResult.valueForKey(UdacityClient.JSONResponseKeys.User)
                
                completionHandler(success: true, firstName: user!.valueForKey(UdacityClient.JSONResponseKeys.FirstName) as! String, lastName: user!.valueForKey(UdacityClient.JSONResponseKeys.LastName) as! String, errorString: nil)
            }
        }
    }
    
    // MARK: - POST Convenience Methods
    
    func getUserID(username: String, password: String, completionHandler: (success: Bool, userID: String?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String: AnyObject]()
        let mutableMethod : String = Methods.Session
        
        let jsonBody : [String:AnyObject] = [
            UdacityClient.JSONBodyKeys.Udacity: [
                UdacityClient.JSONBodyKeys.Username: username,
                UdacityClient.JSONBodyKeys.Password: password
            ]
        ]
        
        /* 2. Make the request */
        _ = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, userID: nil, error: error)
            } else {
                if JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Account) != nil {
                    self.userID = JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Account)!.valueForKey(UdacityClient.JSONResponseKeys.Key) as! String
                    completionHandler(success: true, userID: self.userID, error: nil)
                } else {
                    if JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Error) != nil {
                        completionHandler(success: false, userID: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Error) as! String]))
                    } else {
                        completionHandler(success: false, userID: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to Udacity"]))
                    }
                }
            }
        }
    }
    
    func postCreateSession(username: String, password: String, completionHandler: (result: Int?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String: AnyObject]()
        let mutableMethod : String = Methods.Session
        
        let jsonBody : [String:AnyObject] = [
            UdacityClient.JSONBodyKeys.Udacity: [
                UdacityClient.JSONBodyKeys.Username: username,
                UdacityClient.JSONBodyKeys.Password: password
            ]
        ]
        
        /* 2. Make the request */
        _ = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Account) != nil {
                    self.userID = JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Account)!.valueForKey(UdacityClient.JSONResponseKeys.Key) as! String
                    completionHandler(result: 1, error: nil)
                } else {
                    if JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Error) != nil {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: JSONResult.valueForKey(UdacityClient.JSONResponseKeys.Error) as! String]))
                    } else {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to Udacity"]))
                    }
                }
            }
        }
    }
        
    // MARK: - DELETE Convenience Methods
        
    func deleteSession(completionHandler: (result: Int?, error: NSError?) -> Void) {
            
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String: AnyObject]()
        let mutableMethod : String = Methods.Session
            
        /* 2. Make the request */
        _ = taskForDELETEMethod(mutableMethod, parameters: parameters) { JSONResult, error in
                
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: 1, error: nil)
            }
        }
    }
}
