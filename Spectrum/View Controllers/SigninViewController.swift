//
//  SigninViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

struct RegisterUserResult: Decodable {
    let numberOfUsers: Int
}

struct RegisterUser {
    var username: String
    var userEmail: String
    var userPassword: String
}

var registerUser: RegisterUser = RegisterUser(username: "", userEmail: "", userPassword: "")

class SigninViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var heightConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    var numberOfReadyItems: Int = 0
    
    var isUsernameReady: Bool = false
    var isEmailReady: Bool = false
    var isPasswordReady: Bool = false
    var isConfirmPasswordReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.isHidden = true
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        confirmPasswordLabel.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(_ sender: Any) {
        usernameTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        confirmPasswordTextField.endEditing(true)
        if isUsernameReady && isEmailReady && isPasswordReady && isConfirmPasswordReady {
            state = "signin"
            registerUser.username = usernameTextField.text!
            registerUser.userEmail = emailTextField.text!
            registerUser.userPassword = passwordTextField.text!
            performSegue(withIdentifier: "RegisterContinueSegue", sender: nil)
        }
        else
        {
            print("cannot continue")
        }
    }
    
    @IBAction func usernameEditingDidBegin(_ sender: Any) {
        if usernameTextField.text == "Username" {
            usernameTextField.text = ""
        }
    }
    
    
    @IBAction func emailEditingDidBegin(_ sender: Any) {
        if emailTextField.text == "Email" {
            emailTextField.text = ""
        }
    }
    
    @IBAction func passwordEditingDidBegin(_ sender: Any) {
        if passwordTextField.text == "Password" {
            passwordTextField.text = ""
        }
    }
    
    @IBAction func confirmPasswordEditingDidBegin(_ sender: Any) {
        if confirmPasswordTextField.text == "Confirm Password" {
            confirmPasswordTextField.text = ""
        }
    }
    
    
    @IBAction func usernameEditingDidEnd(_ sender: Any) {
        if usernameTextField.text == "" {
            self.isUsernameReady = false
            usernameTextField.text = "Username"
        }
        else if usernameTextField.text == "Username"{
            
        }
        else
        {
            let url = "http://auburn.edu/~bzl0048/SpectrumServer/API/Register/checkUsername/?username="+usernameTextField.text!
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let userResult = try JSONDecoder().decode(RegisterUserResult.self, from: data)
                    DispatchQueue.main.async {
                        if userResult.numberOfUsers>0{
                            self.usernameLabel.isHidden = false
                            self.isUsernameReady = false
                        }else{
                            self.usernameLabel.isHidden = true
                            self.isUsernameReady = true
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    @IBAction func emailEditingDidEnd(_ sender: Any) {
        if emailTextField.text == "" {
            emailTextField.text = "Email"
            self.isEmailReady = false
        }
        else if emailTextField.text == "Email"{
            
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
    
    @IBAction func passwordEditingDidEnd(_ sender: Any) {
        if passwordTextField.text == "" {
            passwordTextField.text = "Password"
            self.isPasswordReady = false
        }
        else if passwordTextField.text == "Password"{
            
        }
        else if UserRegister.checkPassword(userPassword: passwordTextField.text!){
            passwordLabel.isHidden = true
            self.isPasswordReady = true
        }
        else{
            passwordLabel.isHidden = false
            self.isPasswordReady = false
        }
    }
    
    @IBAction func confirmPasswordEditingDidEnd(_ sender: Any) {
        if confirmPasswordTextField.text == "" {
            confirmPasswordTextField.text = "Confirm Password"
            self.isConfirmPasswordReady = false
        }
        else if confirmPasswordTextField.text == "Confirm Password"{
            
        }
        else if passwordTextField.text == confirmPasswordTextField.text{
            confirmPasswordLabel.isHidden = true
            self.isConfirmPasswordReady = true
        }
        else{
            confirmPasswordLabel.isHidden = false
            self.isConfirmPasswordReady = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        heightConstraintOutlet.constant = 270
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        heightConstraintOutlet.constant = 20
    }
    
}
