//
//  CodeVerificationViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
var state: String = ""

class CodeVerificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func continueAction(_ sender: Any) {
        if state == "signin"  {
            performSegue(withIdentifier: "signInSegue", sender: nil)
        }
        else if state == "resetpassword" {
            performSegue(withIdentifier: "resetPasswordSegue", sender: nil)
        }
    }
    
}
