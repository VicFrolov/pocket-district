//
//  searchResultsTableViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 12/29/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit

class searchResultsTableViewController: UITableViewController {
    

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            if let tbc = self.tabBarController as? CustomTabBarController {
                print(tbc.categorizedArray.count)
                print("lol")
                return tbc.categorizedArray.count
            } else {
                return 0
            }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! searchResultsTableViewCell

        // Configure the cell...
        if let tbc = self.tabBarController as? CustomTabBarController {
            cell.usernameLabel?.text = tbc.categorizedArray[indexPath.row]["screenname"] as! String?
            cell.tweetLabel?.text = tbc.categorizedArray[indexPath.row]["userPost"] as! String?
            cell.tweetTimeLabel?.text = tbc.categorizedArray[indexPath.row]["timePosted"] as! String?
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //reload table data
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


}
