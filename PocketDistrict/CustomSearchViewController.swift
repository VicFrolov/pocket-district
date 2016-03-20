//
//  CustomSearchViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/18/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import Alamofire

class CustomSearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func test() {
        let strUR:String = "http://www.tweetdistrict.com/tw?geoSearchWord=party"

        Alamofire.request(
            .GET, strUR)
            .responseJSON { response in
                debugPrint(response)
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
        test()
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
