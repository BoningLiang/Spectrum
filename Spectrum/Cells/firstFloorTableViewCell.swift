//
//  firstFloorTableViewCell.swift
//  Spectrum
//
//  Created by Boning Liang on 3/31/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class firstFloorTableViewCell: UITableViewCell {

    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var replyTime: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
