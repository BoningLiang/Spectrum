//
//  myHeaderView.swift
//  Spectrum
//
//  Created by Boning Liang on 2/5/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

protocol myHeaderViewDelegate{
    func toggleSection(header: myHeaderView, section: Int)
}

class myHeaderView: UITableViewHeaderFooterView {
    var delegate: myHeaderViewDelegate?
    var section: Int!
    @IBOutlet weak var headerLabel: UILabel!
    

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    
    @objc func selectHeaderView(gesture: UITapGestureRecognizer){
        let cell = gesture.view as! myHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(header: String, section: Int, delegate: myHeaderViewDelegate){
        self.headerLabel.text = header
        self.section = section
        self.delegate = delegate
        self.headerLabel.textColor = UIColor.black
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.darkGray
    }
}
