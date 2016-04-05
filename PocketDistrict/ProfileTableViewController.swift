//
//  ProfileTableViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 4/5/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        
        // unauth() is the logout method for the current user.
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        // Remove the user's uid from storage.
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        // Head back to Login!
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }

}
