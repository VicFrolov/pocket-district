//
//  CuratedSearchTableViewCell.swift
//  Shoes
//
//  Created by Victor Frolov on 12/28/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit

class CuratedSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var logLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
