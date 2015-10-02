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
            
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTouch(sender: AnyObject) {
        UdacityClient.sharedInstance().postCreateSession(EmailText.text!, password: PasswordText.text!) { (success, errorString) in
            if (success != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapNavigationController") as! UINavigationController
                    self.presentViewController(controller, animated: true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = UIAlertController(title: "Alert", message:
                        errorString?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }
}

