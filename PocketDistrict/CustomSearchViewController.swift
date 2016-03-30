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

        // Do any additional setup after loading the view.
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
        let twitterURLRequest: String = "https://quiet-cove-5048.herokuapp.com/tw?\(geoSearchWord)\(geoSearchLat)\(geoSearchLon)\(geoSearchRadius)"
        alamoRequest(twitterURLRequest)
        
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
        var categorizedArray = [[String: AnyObject]]()

        for (var i = 0; i < count; i += 1) {
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
            categorizedArray.append(currentUsersInfo)
        }
        
        for (var j = 0; j < categorizedArray.count; j += 1) {
            print(categorizedArray[j])
            print(" ")
        }
    }

    
    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
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
