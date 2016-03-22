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
        

        print(twitterURLRequest)
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
        for (var i = 0; i < count; i++) {
            if let screen_name = json["statuses"][i]["user"]["screen_name"].string {
                print(screen_name)
            }
            
            if let user_post = json["statuses"][i]["text"].string {
                print(user_post)
            }
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
