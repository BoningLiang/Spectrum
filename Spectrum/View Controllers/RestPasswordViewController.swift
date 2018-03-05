//
//  RestPasswordViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

var public_reset_email: String = ""

class RestPasswordViewController: UIViewController {

    var isEmailReady = false
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
     @IBAction func continueAction(_ sender: Any) {
        
        if isEmailReady{
            public_reset_email = emailTextField.text!
            performSegue(withIdentifier: "ResetPasswordEnterEmailSegue", sender: nil)
            state = "resetpassword"
        }
    }
    
    
    @IBAction func emailEditingDidEnd(_ sender: Any) {
        if emailTextField.text == "" {
            self.isEmailReady = false
        }
        else if UserRegister.checkEmail(userEmail: emailTextField.text!){
            emailLabel.isHidden = true
            self.isEmailReady = true
        }
        else{
            emailLabel.isHidden = false
            self.isEmailReady = false
        }
    }

}
