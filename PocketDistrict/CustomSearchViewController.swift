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
    @IBOutlet weak var searchRadius: UISlider!
    
    var searchLatitude:String?
    var searchLongitude:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func search(sender: AnyObject) {
        let searchWord = searchQ.text
        let r = "\(searchRadius.value)"
        let latitude = searchLatitude
        let longitude = searchLongitude
        customSearch(searchWord!, radius: r, lat: latitude!, lon: longitude!)
        print(r)
    }
    
    func customSearch(q:String, radius:String, lat:String, lon:String) {
        let geoSearchWord = (q == "" ? q : "geoSearchWord=\(q)")
        var geoSearchLat = ""
        
        //if no geoSearchWord is provided, do not append an & for the search
        if geoSearchWord != "" {
            geoSearchLat = "&"
        }
        
        geoSearchLat += "geoSearchWordLat=" + (lat == "" ? "33.9700" : lat)
        
        let geoSearchLon = "&geoSearchWordLon=" + (lon == "" ? "-118.4180" : lon)
        var geoSearchRadius = "&geoSearchWordRad=" + (radius == "" ? "25" : radius)
        geoSearchRadius += "mi"
        let searchWords: String = "https://quiet-cove-5048.herokuapp.com/tw?\(geoSearchWord)\(geoSearchLat)\(geoSearchLon)\(geoSearchRadius)"
        
        let twitterUrlRequest: String = searchWords.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        //make API request using the tabBarController
        if let tbc = self.tabBarController as? CustomTabBarController {
            tbc.alamoRequest(twitterUrlRequest)
            
        }
    }

    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
    }
}
