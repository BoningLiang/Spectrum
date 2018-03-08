//
//  LoginViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

struct LoginUser {
    var username: String
    var userPassword: String
    var isLogin: Bool
    
    init(username: String, userPassword: String) {
        self.username = username
        self.userPassword = userPassword
        self.isLogin = false
    }
}

var loginUser: LoginUser = LoginUser(username: "", userPassword: "")

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var heightConstraintOutlet: NSLayoutConstraint!
    
    var isUsernameReady: Bool = false
    var isPasswordReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func usernameTextFieldTouchDown(_ sender: Any) {
        
    }
    
    @IBAction func usernameTextFieldEditingDidBegin(_ sender: Any) {
        if self.usernameTextField.text == "Username" {
            self.usernameTextField.text="";
        }
    }
    
    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        if self.passwordTextField.text == "Password" {
            self.passwordTextField.text = "";
        }
    }
    
    
    @IBAction func usernameTextFieldEditingDidEnd(_ sender: Any) {
        if (self.usernameTextField.text?.isEmpty)! {
            self.usernameTextField.text = "Username";
            isUsernameReady = false
        }else{
            isUsernameReady = true
        }
    }
    
    @IBAction func passwordTextFieldEditingDidEnd(_ sender: Any) {
        if (self.passwordTextField.text?.isEmpty)! {
            self.passwordTextField.text = "Password";
            isUsernameReady = false
        }else{
            isPasswordReady = true
        }
    }
    
    
    @IBAction func passwordTextFieldTouchDown(_ sender: Any) {
        
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    func loginSpectrum(username: String, password: String) -> Bool
    {
        return true
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        if isUsernameReady && isPasswordReady {
            loginUser.username = usernameTextField.text!
            loginUser.userPassword = passwordTextField.text!
            if(loginSpectrum(username: loginUser.username, password: loginUser.userPassword)){
                performSegue(withIdentifier: "loginSegue", sender: self)
                print("login")
            }
            else{
                print("LoginViewController(): Fail to login.")
            }
            
        }
        else
        {
            print("LoginViewController(): Missing username or password, cannot login")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        heightConstraintOutlet.constant = 270
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        heightConstraintOutlet.constant = 65
    }
    
}
