//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 03/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit
import Foundation
import MapKit

// MARK: - Convenient Resource Methods

extension ParseClient {
    
    // MARK: - GET Convenience Methods
    
    func getStudentLocation(limit: Float, skip: Float, completionHandler: (success: Bool, locations: [StudentLocation], errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParseClient.ParameterKeys.Limit: limit, ParseClient.ParameterKeys.Skip: skip]
        var resultLocations = [StudentLocation]()
        
        /* 2. Make the request */
        taskForGETMethod(Methods.StudentLocation, parameters: parameters) { JSONResult, error in
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, locations: resultLocations, errorString: "Get StudentLocation Failed.")
            } else {
                resultLocations = StudentLocation.locationFromResults((JSONResult.valueForKey(ParseClient.JSONResponseKeys.Results) as? [[String : AnyObject]])!)
                
                completionHandler(success: true, locations: resultLocations, errorString: nil)
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
                //if JSONResult.valueForKey(ParseClient.JSONResponseKeys.Account) != nil {
                    completionHandler(result: 1, error: nil)
                //} else {
                    if JSONResult.valueForKey(ParseClient.JSONResponseKeys.Error) != nil {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: JSONResult.valueForKey(ParseClient.JSONResponseKeys.Error) as! String]))
                    } else {
                        completionHandler(result: nil, error: NSError(domain: "login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to Parse"]))
                    }
                //}
            }
        }
    }
    
    // MARK: - Sample Data
    
    // Some sample data. This is a dictionary that is more or less similar to the
    // JSON data that you will download from Parse.
    
    func hardCodedLocationData() -> [[String : AnyObject]] {
        return  [
            [
                "createdAt" : "2015-02-24T22:27:14.456Z",
                "firstName" : "Jessica",
                "lastName" : "Uelmen",
                "latitude" : 28.1461248,
                "longitude" : -82.75676799999999,
                "mapString" : "Tarpon Springs, FL",
                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
                "objectId" : "kj18GEaWD8",
                "uniqueKey" : 872458750,
                "updatedAt" : "2015-03-09T22:07:09.593Z"
            ], [
                "createdAt" : "2015-02-24T22:35:30.639Z",
                "firstName" : "Gabrielle",
                "lastName" : "Miller-Messner",
                "latitude" : 35.1740471,
                "longitude" : -79.3922539,
                "mapString" : "Southern Pines, NC",
                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
                "objectId" : "8ZEuHF5uX8",
                "uniqueKey" : 2256298598,
                "updatedAt" : "2015-03-11T03:23:49.582Z"
            ], [
                "createdAt" : "2015-02-24T22:30:54.442Z",
                "firstName" : "Jason",
                "lastName" : "Schatz",
                "latitude" : 37.7617,
                "longitude" : -122.4216,
                "mapString" : "18th and Valencia, San Francisco, CA",
                "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
                "objectId" : "hiz0vOTmrL",
                "uniqueKey" : 2362758535,
                "updatedAt" : "2015-03-10T17:20:31.828Z"
            ], [
                "createdAt" : "2015-03-11T02:48:18.321Z",
                "firstName" : "Jarrod",
                "lastName" : "Parkes",
                "latitude" : 34.73037,
                "longitude" : -86.58611000000001,
                "mapString" : "Huntsville, Alabama",
                "mediaURL" : "https://linkedin.com/in/jarrodparkes",
                "objectId" : "CDHfAy8sdp",
                "uniqueKey" : 996618664,
                "updatedAt" : "2015-03-13T03:37:58.389Z"
            ]
        ]
    }
}
