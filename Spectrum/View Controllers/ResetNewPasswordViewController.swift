//
//  ResetNewPasswordViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/4/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

struct NewPassword {
    var email: String
    var newPassword: String
}

var public_newPassword: NewPassword = NewPassword(eamil: "", newPassword: "")

class ResetNewPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordLabel: UILabel!
    
    @IBOutlet weak var confirmNewPasswordLabel: UILabel!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    var isPasswordReady: Bool = false
    var isConfirmPasswordReady: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPasswordLabel.isHidden = true
        confirmNewPasswordLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newPasswordEditingDidEnd(_ sender: Any) {
        if newPasswordTextField.text == "" {
            self.isPasswordReady = false
        }
        else if UserRegister.checkPassword(userPassword: newPasswordTextField.text!){
            newPasswordLabel.isHidden = true
            self.isPasswordReady = true
        }
        else{
            newPasswordLabel.isHidden = false
            self.isPasswordReady = false
        }
    }
    @IBAction func confirmPasswordEditingDidEnd(_ sender: Any) {
        if confirmNewPasswordTextField.text == "" {
            self.isConfirmPasswordReady = false
        }
        else if newPasswordTextField.text == confirmNewPasswordTextField.text{
            confirmNewPasswordLabel.isHidden = true
            self.isConfirmPasswordReady = true
        }
        else{
            confirmNewPasswordLabel.isHidden = false
            self.isConfirmPasswordReady = false
        }
    }
    @IBAction func continueAction(_ sender: Any) {
        if self.isPasswordReady && self.isConfirmPasswordReady {
            public_newPassword.email = public_reset_email
            public_newPassword.newPassword = self.newPasswordTextField.text!
            performSegue(withIdentifier: "ResetNewPasswordSegue", sender: nil)
        }
    }
    
}
