//
//  SigninViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(_ sender: Any) {
        state = "signin"
    }
    
    @IBAction func usernameTouchDown(_ sender: Any) {
        if usernameTextField.text == "Username" {
            usernameTextField.text = ""
            usernameTextField.textColor = UIColor.black
        }
    }
    
    @IBAction func emailTouchDown(_ sender: Any) {
        if emailTextField.text == "Email" {
            emailTextField.text = ""
            emailTextField.textColor = UIColor.black
        }
    }
    
    @IBAction func passwordTouchDown(_ sender: Any) {
        if passwordTextField.text == "Password" {
            passwordTextField.text = ""
            passwordTextField.textColor = UIColor.black
        }
    }
    
    @IBAction func confirmPasswordTouchDown(_ sender: Any) {
        if confirmPasswordTextField.text == "Confirm Password" {
            confirmPasswordTextField.text = ""
            confirmPasswordTextField.textColor = UIColor.black
        }
    }
    
    
    
    
    
    @IBAction func usernameEditingDidEnd(_ sender: Any) {
        if usernameTextField.text == "" {
            usernameTextField.text = "Username"
            usernameTextField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func emailEditingDidEnd(_ sender: Any) {
        if emailTextField.text == "" {
            emailTextField.text = "Email"
            emailTextField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: Any) {
        if passwordTextField.text == "" {
            passwordTextField.text = "Password"
            passwordTextField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func confirmPasswordEditingDidEnd(_ sender: Any) {
        if confirmPasswordTextField.text == "" {
            confirmPasswordTextField.text = "Confirm Password"
            confirmPasswordTextField.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    
}
