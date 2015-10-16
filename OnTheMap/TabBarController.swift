//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 08/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    @IBAction func pinButtonTouchUp(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
        self.navigationController!.pushViewController(controller, animated: true)
    }
}
