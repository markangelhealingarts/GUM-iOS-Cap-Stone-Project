//
//  GroupCell.swift
//  GUM-ios
//
//  Created by Tim Johnson on 5/2/22.
//

import UIKit

class GroupCell: UITableViewCell {

    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var membersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
