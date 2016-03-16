//
//  resultsContainerViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 3/15/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit

class resultsContainerViewController: UIViewController {


@IBOutlet weak var listView: UIView!
@IBOutlet weak var mapView: UIView!
    


@IBAction func indexChanged(sender: AnyObject) {
    switch sender.selectedSegmentIndex {
        case 0 :
            listView.hidden = false
            mapView.hidden = true
        case 1:
            listView.hidden = true
            mapView.hidden = false
        default:
            break
    }
}

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
