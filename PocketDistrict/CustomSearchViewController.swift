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

    
//    var userLat:Double
//    var userLon:Double
//    var Radius:Int


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAccount(sender: AnyObject) {
        let q = searchQ.text!
        
        customSearch(q)
    }
    
    func customSearch(q:String, radius:String = "100") {
        let fullSearch: String = "https://quiet-cove-5048.herokuapp.com/tw?geoSearchWord=\(q)&geoSearchWordLat=33.9605648&geoSearchWordLon=-118.41797910000001&geoSearchWordRad=\(radius)mi"
        
        Alamofire.request(.GET, fullSearch).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let what = json["statuses"][1]["user"]["screen_name"].string
                    print(what)
                    print(json)
                }
            case .Failure(let error):
                print(error)
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
