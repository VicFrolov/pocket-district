//
//  TypeOfActivityTableViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 1/2/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TypeOfActivityTableViewController: UITableViewController {
    
    
    var activityNames = ["Nightlife", "Eats", "Day Stuff", "Hiring", ""]
    
    var activityPic = ["nightlife", "eatsPic", "dayPic", "jobsPic", "salesPic"]
    
    var slogan = ["Hit the town", "Best grub in town", "find events", "get a job", "because saving money rocks"]
    
    var searchQuery = ["\"happy hour\"", "lunch", "show", "hiring%20OR%20job", "sales%20OR%20discount"]

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cellIdentifier = "Cell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TypeOfActivityTableViewCell
            cell.activityLabel?.text = activityNames[indexPath.row]
            cell.bgImage?.image = UIImage(named: activityPic[indexPath.row])
            cell.sloganLabel?.text = slogan[indexPath.row]
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
        quickSearch(indexPath.row, lat:"", lon:"")
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // remove spacing between table and navbar
        self.automaticallyAdjustsScrollViewInsets = false

    }

    
    //forces the navbar to appear, even if it disappeared in previous controller
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    func quickSearch(indexPath: Int, lat: String, lon: String) {
        let geoSearchWord = "geoSearchWord=\(searchQuery[indexPath])"
        let geoSearchLat = "&geoSearchWordLat=" + (lat == "" ? "33.9700" : lat)
        let geoSearchLon = "&geoSearchWordLon=" + (lon == "" ? "-118.4180" : lon)
        let geoSearchRadius = "&geoSearchWordRad=5mi"
        let searchWords: String = "https://quiet-cove-5048.herokuapp.com/tw?\(geoSearchWord)\(geoSearchLat)\(geoSearchLon)\(geoSearchRadius)"
        
        let twitterUrlRequest: String = searchWords.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        print(twitterUrlRequest)
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
                
                tbc.categorizedArray.append(currentUsersInfo)
            }
            
            for i in (0 ..< tbc.categorizedArray.count) {
                print(tbc.categorizedArray[i])
                print(" ")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityNames.count
    }

}
