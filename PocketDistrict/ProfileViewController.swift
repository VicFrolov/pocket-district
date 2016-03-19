//
//  ProfileViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/16/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
