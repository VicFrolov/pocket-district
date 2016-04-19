//
//  customSearchLocationTableViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 4/19/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit

class customSearchLocationTableViewController: UITableViewController {
    
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var userLocationInput: UITextField!
    
    @IBAction func customLocationToggle(sender: UISwitch) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //hardcoded all the heights to allow the collapsing of the custom address cell
        if indexPath.row == 0 {
            return 270
        } else if indexPath.row == 1 {
            return 57
        } else if indexPath.row == 3 {
            return 107
        } else if indexPath.row == 2 && locationToggle.on == true {
            return 0
        } else if indexPath.row == 2 && locationToggle.on == false {
            return 100
        }
        return self.tableView.rowHeight;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }




}
