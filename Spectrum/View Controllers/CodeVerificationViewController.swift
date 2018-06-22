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

    var timer = Timer()
    var seconds = 60
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var reSendButton: UIButton!
    
    @IBOutlet weak var codeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgLabel.isHidden = true
        
        sendCode()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func countdownClock()
    {
        self.seconds = self.seconds - 1
        self.reSendButton.setTitle(self.seconds.description, for: .normal)
        if self.seconds == 0{
            reSendButton.isEnabled = true
            self.reSendButton.setTitle("resend", for: .normal)
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func sendCode(){
        let url = baseUrl+"/SpectrumServer/API/SendCodeEmail/?firstName="+registerUser.username+"&email="+registerUser.userEmail
        print(url)
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let result = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    if result.result! > 0{
                        print("code send success")
                    }else{
                        
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        self.reSendButton.isEnabled = false
        self.seconds = 60
        self.reSendButton.setTitle(self.seconds.description, for: .normal)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownClock), userInfo: nil, repeats: true)
    }
    
    @IBAction func reSendCodeAction(_ sender: Any) {
        sendCode()
    }
    
    func checkCode(code: String) -> Bool{
        let checkResult: Bool = UserRegister.checkCode(code: code)
        print(checkResult)
        return checkResult
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
        if checkCode(code: self.codeTextField.text!) {
            let url = baseUrl+"/SpectrumServer/API/VerifyCode/?code="+self.codeTextField.text!+"&email="+registerUser.userEmail
            print(url)
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    DispatchQueue.main.async {
                        if result.result! > 0{
                            if state == "signin"  {
                                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                            }
                            else if state == "resetpassword" {
                                self.performSegue(withIdentifier: "resetPasswordSegue", sender: nil)
                            }
                        }else{
                            self.msgLabel.text = "Wrong code."
                            self.msgLabel.isHidden = false
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        else{
            self.msgLabel.text = "Unvalid code."
            self.msgLabel.isHidden = false
        }
    }
}
