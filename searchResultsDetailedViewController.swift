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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
