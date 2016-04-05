//
//  searchResultsTableViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 12/29/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit

class searchResultsTableViewController: UITableViewController {
    
    var username = ["Jack", "Bob", "Tyrone", "Jack", "Bob", "Tyrone"]
    var userImage = ["PicJack", "PicBob", "PicTyrone", "PicJack", "PicBob", "PicTyrone"]
    var tweetContent = ["Hello world", "I can't believe I didn't kill myself yet", "Twitter is a service I should not be using, yet here I am.",
        "Hello world", "I can't believe I didn't kill myself yet", "Twitter is a service I should not be using, yet here I am."]
    var tweetTime = ["1:03", "Unknown", "4:30", "1:03", "Unknown", "4:30"]
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath
//        indexPath: NSIndexPath) -> UITableViewCell {
//            let cellIdentifier = "Cell"
//            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! searchResultsTableViewCell
//            
//            // Configure the cell...
//            //cell.usernameLabel?.text = username[indexPath.row]
//
//            if let tbc = self.tabBarController as? CustomTabBarController {
//                if tbc.loadResults {
////                    tbc.loadResults = false
//                    
//                    cell.usernameLabel?.text = tbc.categorizedArray[indexPath.row]["screenname"] as! String?
//                    cell.tweetLabel?.text = tbc.categorizedArray[indexPath.row]["userPost"] as! String?
//
//                
//                }
//                
//            }
//
//        
////            cell.tweetTimeLabel?.text = tweetTime[indexPath.row]
////            cell.userImageLabel?.image = UIImage(named: "cafelore")
//            return cell
//    }
//    
//    //MARKER: Swipe more and delete for searches
//    
//    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//            // Social Sharing Button
//        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: {
//                (action, indexPath) -> Void in let defaultText = "Check this out: \(self.username[indexPath.row]) writes \(self.tweetContent[indexPath.row])"
//                    let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
//                    self.presentViewController(activityController, animated: true, completion: nil)
//        })
//        // Delete button
//        let deleteAction = UITableViewRowAction(style:
//            UITableViewRowActionStyle.Default, title: "Delete",handler: { (action,
//            indexPath) -> Void in
//            // Delete the row from the data source
//            self.username.removeAtIndex(indexPath.row)
//            self.userImage.removeAtIndex(indexPath.row)
////            self.tweetContent.removeAtIndex(indexPath.row)
////            self.tweetTime.removeAtIndex(indexPath.row)
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
//        })
    
        
//        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,
//            blue: 253.0/255.0, alpha: 1.0)
//        
//        return [deleteAction, shareAction]
//    }

    
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
