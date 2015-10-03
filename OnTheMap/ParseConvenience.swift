//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 03/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Convenient Resource Methods

extension ParseClient {
    
    // MARK: - GET Convenience Methods
    
    func getStudentLocation(limit: Float, skip: Float, completionHandler: (success: Bool, errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters = [ParseClient.ParameterKeys.Limit: limit, ParseClient.ParameterKeys.Skip: skip]
        
        /* 2. Make the request */
        taskForGETMethod(Methods.StudentLocation, parameters: parameters) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, errorString: "Get StudentLocation Failed.")
            } else {
                if let requestToken = JSONResult.valueForKey(ParseClient.JSONResponseKeys.Account) as? String {
                    completionHandler(success: true, errorString: nil)
                } else {
                    completionHandler(success: false, errorString: "Get StudentLocation Failed.")
                }
            }
        }
    }
    
    // MARK: - POST Convenience Methods
    
    func postCreateSession(username: String, password: String, completionHandler: (result: Int?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String: AnyObject]()
        let mutableMethod : String = Methods.StudentLocation
        
        let jsonBody : [String:AnyObject] = [
            ParseClient.JSONBodyKeys.Username: username,
            ParseClient.JSONBodyKeys.Password: password
        ]
        
        /* 2. Make the request */
        _ = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if JSONResult.valueForKey(ParseClient.JSONResponseKeys.Account) != nil {
                    completionHandler(result: 1, error: nil)
                } else {
                    if JSONResult.valueForKey(ParseClient.JSONResponseKeys.Error) != nil {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: JSONResult.valueForKey(ParseClient.JSONResponseKeys.Error) as! String]))
                    } else {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to Parse"]))
                    }
                }
            }
        }
    }
}
