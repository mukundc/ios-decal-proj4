//
//  GroupTableViewCell.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

