//
//  CustomTabBarController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/29/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class CustomTabBarController: UITabBarController {
    
    
    
    var categorizedArray = [[String: AnyObject]]()
    var loadResults = false;
    
    func alamoRequest(url: String) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let count = json["statuses"].count
                    self.twitterResults(json, count:count)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func twitterResults(json:JSON, count:Int) {
        //jump to new tab to reveal results
        self.selectedIndex = 2;
        
        //set loadResults to true so that everytime that tab bar appears it doesn't
        //load over and over, and only on a search.
        self.loadResults = true
        
        for i in (0 ..< count) {
            var currentUsersInfo = [String:AnyObject]()
            
            if let screenname = json["statuses"][i]["user"]["screen_name"].string {
                currentUsersInfo["screenname"] = screenname
            }
            if let userPost = json["statuses"][i]["text"].string {
                currentUsersInfo["userPost"] = userPost
            }
            if let userPic = json["statuses"][i]["user"]["profile_image_url_https"].string {
                currentUsersInfo["userPicUrl"] = userPic
            }
            if let timePosted = json["statuses"][i]["created_at"].string {
                currentUsersInfo["timePosted"] = timePosted
            }
            if let geoLat = json["statuses"][i]["geo"]["coordinates"][0].float {
                currentUsersInfo["geoLat"] = geoLat
            }
            if let geoLon = json["statuses"][i]["geo"]["coordinates"][1].float {
                currentUsersInfo["geoLon"] = geoLon
            }
            
            self.categorizedArray.append(currentUsersInfo)
        }
        
        for i in (0 ..< self.categorizedArray.count) {
            print(self.categorizedArray[i])
            print(" ")
        }
    }


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

}
