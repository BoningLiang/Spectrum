//
//  customManageCaseTableViewCell.swift
//  Spectrum
//
//  Created by Boning Liang on 3/26/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class customManageCaseTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var caseSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
