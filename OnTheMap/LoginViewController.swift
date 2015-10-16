//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 10/09/15.
//  Copyright (c) 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        session = NSURLSession.sharedSession()
    }

    @IBAction func loginButtonTouch(sender: AnyObject) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        
        UdacityClient.sharedInstance().authenticate(EmailText.text!, password: PasswordText.text!) { (success, firstName, lastName, errorString) in
            if (success) {
                self.appDelegate.firstName = firstName
                self.appDelegate.lastName = lastName
                
                dispatch_async(dispatch_get_main_queue(), {
                    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapNavigationController") as! UINavigationController
                    self.presentViewController(controller, animated: true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = UIAlertController(title: "Alert", message:
                        errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    animation.fromValue = NSValue(CGPoint: CGPointMake(self.EmailText.center.x - 10, self.EmailText.center.y))
                    animation.toValue = NSValue(CGPoint: CGPointMake(self.EmailText.center.x + 10, self.EmailText.center.y))
                    self.EmailText.layer.addAnimation(animation, forKey: "position")
                    
                    animation.fromValue = NSValue(CGPoint: CGPointMake(self.PasswordText.center.x - 10, self.PasswordText.center.y))
                    animation.toValue = NSValue(CGPoint: CGPointMake(self.PasswordText.center.x + 10, self.PasswordText.center.y))
                    self.PasswordText.layer.addAnimation(animation, forKey: "position")
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }
}

