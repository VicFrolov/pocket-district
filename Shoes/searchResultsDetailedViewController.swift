//
//  searchResultsDetailedViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 1/2/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit

class searchResultsDetailedViewController: UIViewController {
    
    @IBOutlet var userPic:UIImageView!
    var restaurantImage = "nightlife"

    override func viewDidLoad() {
        super.viewDidLoad()
        userPic.image = UIImage(named: restaurantImage)
    
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
