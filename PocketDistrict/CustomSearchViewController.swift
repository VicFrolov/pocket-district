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
        
        //make API request using the tabBarController
        if let tbc = self.tabBarController as? CustomTabBarController {
            tbc.alamoRequest(twitterUrlRequest)
            
        }
    }

    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
    }
}
