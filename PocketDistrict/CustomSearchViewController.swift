//
//  CustomSearchViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/18/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomSearchTableViewController: UITableViewController {

    @IBOutlet weak var searchQ: UITextField!
    @IBOutlet weak var searchRadius: UITextField!
    @IBOutlet weak var searchLat: UITextField!
    @IBOutlet weak var searchLon: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func search(sender: AnyObject) {
        let searchWord = searchQ.text
        let r = searchRadius.text
        let latitude = searchLat.text
        let longitude = searchLon.text
        customSearch(searchWord!, radius: r!, lat: latitude!, lon: longitude!)
    }
    
    func customSearch(q:String, radius:String, lat:String, lon:String) {
        let geoSearchWord = (searchQ.text! == "" ? q : "geoSearchWord=\(q)")

        //if no geoSearchWord is provided, do not append an & for the search
        var geoSearchLat = ""
        
        if geoSearchWord != "" {
            geoSearchLat = "&"
        }
        
        geoSearchLat += "geoSearchWordLat=" + (searchLat.text! == "" ? "33.9700" : lat)
        
        let geoSearchLon = "&geoSearchWordLon=" + (searchLon.text! == "" ? "-118.4180" : lon)
        var geoSearchRadius = "&geoSearchWordRad=" + (searchRadius.text! == "" ? "25" : radius)
        geoSearchRadius += "mi"
        let searchWords: String = "https://quiet-cove-5048.herokuapp.com/tw?\(geoSearchWord)\(geoSearchLat)\(geoSearchLon)\(geoSearchRadius)"
        
        let twitterUrlRequest: String = searchWords.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        alamoRequest(twitterUrlRequest)
        
    }
    
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
        self.tabBarController!.selectedIndex = 2;
        
        
        //Ensure that CustomTabBarController exists
        if let tbc = self.tabBarController as? CustomTabBarController {
            //set loadResults to true so that everytime that tab bar appears it doesn't 
            //load over and over, and only on a search.
            tbc.loadResults = true
            
            for i in (0 ..< count) {
                var currentUsersInfo = [String:String]()
            
                if let screenname = json["statuses"][i]["user"]["screen_name"].string {
                    currentUsersInfo["screenname"] = screenname
                }
            
                if let userPost = json["statuses"][i]["text"].string {
                    currentUsersInfo["userPost"] = userPost
                }
            
                if let userPic = json["statuses"][i]["user"]["profile_image_url_https"].string {
                    currentUsersInfo["userPicUrl"] = userPic
                }
                if let timePosted = json["statuses"][i]["user"]["created_at"].string {
                    currentUsersInfo["timePosted"] = timePosted
                }
                
                tbc.categorizedArray.append(currentUsersInfo)
            }
        
            for i in (0 ..< tbc.categorizedArray.count) {
                print(tbc.categorizedArray[i])
                print(" ")
            }
        }
    }

    
    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
    }
}
