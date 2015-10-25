//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 05/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import MapKit

struct StudentLocation {
    
    var firstName = ""
    var lastName = ""
    var mediaURL = ""
    var latitude = 0.0
    var longitude = 0.0
    var updatedAt = NSDate()
    
    /* Construct a StudentLocation from a dictionary */
    init(dictionary: [String : AnyObject]) {
        
        firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
        mediaURL = dictionary["mediaURL"] as! String
        
        latitude = CLLocationDegrees(dictionary["latitude"] as! Double)
        longitude = CLLocationDegrees(dictionary["longitude"] as! Double)

        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"        
        updatedAt = (dateFormatter.dateFromString(dictionary["updatedAt"] as! String) as NSDate?)!
    }
    
    func getAnnotation() -> MKPointAnnotation {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(firstName) \(lastName)"
        annotation.subtitle = mediaURL
        
        return annotation
    }
    
    /* Helper: Given an array of dictionaries, convert them to an array of StudentLocation objects */
    static func locationFromResults(results: [[String : AnyObject]]) -> [StudentLocation] {
        var locations = [StudentLocation]()
        
        for result in results {
            locations.append(StudentLocation(dictionary: result))
        }
        
        return locations
    }
    
    /* Helper: Given an array of dictionaries, convert them to an array of MKPointAnnotation objects */
    static func annotationsFromResults(results: [[String : AnyObject]]) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for result in results {
            annotations.append(StudentLocation(dictionary: result).getAnnotation())
        }
        
        return annotations
    }
    
    static func annotationsFromLocations(locations: [StudentLocation]) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            annotations.append(location.getAnnotation())
        }
        
        return annotations
    }
}
