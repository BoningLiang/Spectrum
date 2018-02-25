//
//  descriptionViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/23/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class descriptionViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = casePublic?.caseDescription
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
