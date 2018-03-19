//
//  DiscussionsTableViewCell.swift
//  Spectrum
//
//  Created by Boning Liang on 3/18/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class DiscussionsTableViewCell: UITableViewCell {

    @IBOutlet weak var discussionContent: UILabel!
    @IBOutlet weak var discussionDateTime: UILabel!
    @IBOutlet weak var discussionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
