    //
//  LoginPromptViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/18/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit

class LoginPromptViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
        }
    }
    
    
    @IBAction func tryLogin(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            // Login with the Firebase's authUser method
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    // Be sure the correct uid is stored.
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                }
            })
            
        } else {
            // There was a problem
            loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
    }
    
    func loginErrorAlert(title: String, message: String) {
        // Called upon login error to let the user know login didn't work.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
