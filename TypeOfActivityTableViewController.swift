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
    
    var searchQuery = ["\"happy hour\"", "lunch", "show", "hiring OR job", "sales OR discount"]

    
    
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
        
        //make API request using tabBarController methods
        if let tbc = self.tabBarController as? CustomTabBarController {
            tbc.alamoRequest(twitterUrlRequest)

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
