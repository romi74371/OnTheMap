//
//  LocationlistViewController.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 05/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit

class LocationlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.locationsTableView?.delegate = self;
        self.locationsTableView?.dataSource = self;
        
        // Create and set the logout button
        self.parentViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutButtonTouchUp")
        
        self.parentViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refreshView")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.locationsTableView?.reloadData();
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "LocationlistTableViewCell"
        
        let location = appDelegate.locations![indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! UITableViewCell?
        
        /* Set cell defaults */
        cell!.textLabel!.text = "\(location.firstName) \(location.lastName)"
        cell!.imageView!.image = UIImage(named: "pinIco")
        cell!.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.locations!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        let location = appDelegate.locations![indexPath.row]
        app.openURL(NSURL(string: location.mediaURL)!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }

    func logoutButtonTouchUp() {
        UdacityClient.sharedInstance().deleteSession() { (success, errorString) in
            if (success != nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
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
    
    func refreshView() {
        ParseClient.sharedInstance().getStudentLocation(100, skip: 10, order: ParseClient.JSONResponseKeys.CreatedAt) { (success, result, errorString) in
            if (success == true) {
                print("Locations loaded!")
                self.appDelegate.locations = result
                self.locationsTableView?.reloadData();
            } else {
                print("Loading locations error!")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = UIAlertController(title: "Alert", message:
                        errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }
}

