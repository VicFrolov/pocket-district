//
//  searchResultsTableViewCell.swift
//  Shoes
//
//  Created by Victor Frolov on 12/29/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit

class searchResultsTableViewCell: UITableViewCell {
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userImageLabel: UIImageView!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var tweetTimeLabel: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
