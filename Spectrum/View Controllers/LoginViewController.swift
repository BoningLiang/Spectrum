//
//  LoginViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func usernameTextFieldTouchDown(_ sender: Any) {
        if self.usernameTextField.text == "Username" {
            self.usernameTextField.text="";
            self.usernameTextField.textColor = UIColor.black;
        }
    }
    
    
    @IBAction func usernameTextFieldEditingDidEnd(_ sender: Any) {
        if (self.usernameTextField.text?.isEmpty)! {
            self.usernameTextField.text = "Username";
            self.usernameTextField.textColor = UIColor.lightGray;
        }
    }
    
    @IBAction func passwordTextFieldEditingDidEnd(_ sender: Any) {
        if (self.passwordTextField.text?.isEmpty)! {
            self.passwordTextField.text = "Password";
            self.passwordTextField.textColor = UIColor.lightGray;
        }
    }
    
    
    @IBAction func passwordTextFieldTouchDown(_ sender: Any) {
        if self.passwordTextField.text == "Password" {
            self.passwordTextField.text = "";
            self.passwordTextField.textColor = UIColor.black;
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    

}
