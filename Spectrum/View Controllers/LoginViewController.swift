//
//  LoginViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import CoreData

//struct LoginUser {
//    var username: String
//    var userPassword: String
//    var isLogin: Bool
//
//    init(username: String, userPassword: String) {
//        self.username = username
//        self.userPassword = userPassword
//        self.isLogin = false
//    }
//}
//
//var loginUser: LoginUser = LoginUser(username: "", userPassword: "")

var loginuser: UserController = UserController();

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var heightConstraintOutlet: NSLayoutConstraint!
    
    var isUsernameReady: Bool = false
    var isPasswordReady: Bool = false
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchLoginSessionRequest:NSFetchRequest<LoginSessionEntity> = LoginSessionEntity.fetchRequest()

        do {
            let loginSessionEntity = try CoreDataService.context.fetch(fetchLoginSessionRequest)
            if loginSessionEntity.count>0 {
                self.usernameTextField.text = loginSessionEntity[loginSessionEntity.count-1].username
                self.checkUsernameTextField()
            }
        } catch {
            print("LoginViewController: viewDidLoad(): error")
        }
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let borderColor: CGColor = UIColor(red:0.01, green:0.14, blue:0.30, alpha:1.0).cgColor
        
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = borderColor
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = borderColor
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = borderColor
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        self.view.addSubview(activityIndicator)
        
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
    
    
    
    @IBAction func usernameTextFieldTouchDown(_ sender: Any) {
        
    }
    
    @IBAction func usernameTextFieldEditingDidBegin(_ sender: Any) {
        if self.usernameTextField.text == "Username" {
            self.usernameTextField.text="";
        }
    }
    
    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        if self.passwordTextField.text == "Password" {
            self.passwordTextField.isSecureTextEntry = true
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
            self.passwordTextField.isSecureTextEntry = false
            isUsernameReady = false
        }else{
            isPasswordReady = true
        }
    }
    
    
    @IBAction func passwordTextFieldTouchDown(_ sender: Any) {
        
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    func loginSpectrum(username: String, userPassword: String)
    {
        let url = baseUrl+"/SpectrumServer/API/Login/?username="+username+"&password="+userPassword;
        let request = URLRequest(url: URL(string: url)!)
        print(url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let result = try JSONDecoder().decode(LoginResult.self, from: data)
                DispatchQueue.main.async {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    if result.result>0
                    {
                        loginuser.isLogin = true
                        
//                        let dateFormatter = DateIntervalFormatter()
//                        dateFormatter.dateFormat = "dd:MM:yyy hh:mm:ss"
                        
                        
//                        let fetchRequest: NSFetchRequest<LoginSessionEntity> = LoginSessionEntity.fetchRequest()
//                        var loginSessionResult = [LoginSessionEntity]()
//                        let context = CoreDataService.context
//                        var subPredicates = [NSPredicate]()
//                        let predicate = NSPredicate(format: "username == %@", username)
//                        subPredicates.append(predicate)
//                        if subPredicates.count>0 {
//                            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
//                            fetchRequest.predicate = compoundPredicates
//                        }
//                        do {
//                            print("update login session entity...")
//                            loginSessionResult = try context.fetch(fetchRequest)
//                        }catch{
//
//                            print("loginSpectrum(): false 1")
//                        }
//                        if loginSessionResult.count>0{
//                            let managedObject = loginSessionResult[0]
//                            managedObject.setValue(true, forKey: "isLogin")
//                            do{
//                                try context.save()
//                                print("loginSpectrum(): update login session entity success")
//                                // true
//                            } catch{
//                                print("loginSpectrum(): false 1")
//                                // false
//                            }
//                        }
//                        else if loginSessionResult.count == 0 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd:MM:yyy hh:mm:ss"
                        
                        
                        let fetchLoginSessionRequest:NSFetchRequest<LoginSessionEntity> = LoginSessionEntity.fetchRequest()
                        
                        do {
                            let loginSessionEntity = try CoreDataService.context.fetch(fetchLoginSessionRequest)
                            if loginSessionEntity.count>0 {
                                
                                loginSessionEntity[0].username = username
                                loginSessionEntity[0].isLogin = true
                                loginSessionEntity[0].password = userPassword
                                loginSessionEntity[0].lastLoginTime = dateFormatter.string(from: Date())
                                CoreDataService.saveContext()
                            }
                            else{
                                let loginSessionEntity = LoginSessionEntity(context: CoreDataService.context)
                                loginSessionEntity.username = username
                                loginSessionEntity.password = userPassword
                                loginSessionEntity.lastLoginTime = dateFormatter.string(from: Date())
                                loginSessionEntity.isLogin = true
                                CoreDataService.saveContext()
                                
                                print("loginSpectrum(): success add an new entity")
                            }
                        } catch {
                            print("")
                        }
//                        }
                        
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                        print("LoginViewController(): Success to login.")
                        
                    }else{
                        loginuser.isLogin = false
                        let alertView = UIAlertController(title: "Login Failure", message: "Please check your username and password", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            print("Press OK")
                        })
                        alertView.addAction(ok)
                        self.present(alertView, animated: true, completion: nil)
                        print("LoginViewController(): Fail to login.")
                    }
                }
            }catch{
                print("loginSpectrum(): ", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        if isUsernameReady && isPasswordReady {
            loginuser.username = usernameTextField.text!
            loginuser.userPassword = passwordTextField.text!
            loginSpectrum(username: loginuser.username!, userPassword: loginuser.userPassword!)
        }
        else
        {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator.stopAnimating()
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
    
    func checkUsernameTextField() {
        if (self.usernameTextField.text?.isEmpty)!
        {
            self.usernameTextField.text = "Username";
            isUsernameReady = false
        }
        else{
            if self.usernameTextField.text == "Username"{
                isUsernameReady = false
            }
            isUsernameReady = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        heightConstraintOutlet.constant = 90
    }
    
}
