//
//  CuratedViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 12/28/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit

class CuratedViewController: UITableViewController {
    
    var cities = ["Near Me", "Los Angeles", "New York", "Montreal"]
    var slogan = ["Right Here, Right Now", "Winter Break Events", "Best Shows and Musicals", "Best Eats"]
    var images = ["cl", "LA", "NY", "mtl"]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CuratedSearchTableViewCell
        
        // Configure the cell...
        cell.cityLabel?.text = cities[indexPath.row]
        //cell.logLabel?.text = slogan[indexPath.row]
        cell.thumbnailImageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //unhide the hidden navbar in the login page
        UIApplication.sharedApplication().statusBarHidden = false

        //remove back button text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // remove spacing between table and navbar
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //enable navbar scroll dissappear
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

}
