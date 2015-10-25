//
//  StudentLocationDetailViewController.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 06/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit
import MapKit

class PostViewController: UIViewController, UITextFieldDelegate  {
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    var location: StudentLocation!
    let annotation = MKPointAnnotation()
    
    var shouldMoveKeyboard = false
    
    @IBOutlet weak var studentLocationText: UITextField!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var browseButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var cancelButton : UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel:")
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationItem.rightBarButtonItem = cancelButton
        
        self.mapView.hidden = true
        self.urlText.hidden = true
        self.submitButton.hidden = true
        self.activityIndicator.hidden = true
        self.browseButton.hidden = true
        
        self.studentLocationText.hidden = false
        self.findButton.hidden = false
        self.infoLabel.hidden = false
        self.infoLabel.text = "Where are you studying today?"
    }
    
    @IBAction func browseTouchUp(sender: AnyObject) {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: self.urlText.text!)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: self.urlText.text!)!)
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                let alertController = UIAlertController(title: "Alert", message:
                    "Invalid input URL", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }

    }
    
    @IBAction func submitTouchUp(sender: AnyObject) {
        ParseClient.sharedInstance().postStudentLocation(self.appDelegate.firstName!, lastName: self.appDelegate.lastName!, uniqueKey: self.appDelegate.userID, mapString: studentLocationText.text!, mediaURL: urlText.text!, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude) { (success, errorString) in
            if (success == true) {
                print("Location stored!")
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationController?.popViewControllerAnimated(true)
                })
            } else {
                print("Submiting location error!")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = UIAlertController(title: "Alert", message:
                        errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }
    
    func loadLocation(loacationName :String, completionHandler: (Bool) -> ()) {
        CLGeocoder().geocodeAddressString(loacationName) { (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                self.annotation.coordinate = CLLocationCoordinate2D(latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!)
                self.annotation.title = "\(self.appDelegate.firstName) \(self.appDelegate.lastName)"
            
                completionHandler(true)
                
            }else{
                completionHandler(false)
            }
        }
    }
    
    @IBAction func searchLocationTouchUp(sender: AnyObject) {
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        loadLocation(studentLocationText.text!) { success in
            if (success == true) {
                self.mapView.addAnnotation(self.annotation)
                
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: self.annotation.coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
                self.mapView.hidden = false
                self.urlText.hidden = false
                self.submitButton.hidden = false
                self.browseButton.hidden = false
                
                self.studentLocationText.hidden = true
                self.findButton.hidden = true
                self.infoLabel.hidden = false
                self.infoLabel.text = "URL"
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = UIAlertController(title: "Alert", message:
                        "Location does not exists!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
            
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
        }
    }

    func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        self.shouldMoveKeyboard = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        self.view.endEditing(true)
        
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.shouldMoveKeyboard {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.shouldMoveKeyboard {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
}
