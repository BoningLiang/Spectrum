//
//  NewTopicViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/16/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class Result: Decodable{
    var result: Int
}

class NewTopicViewController: UIViewController {

    var newTopic: String = ""
    var newTopicContent: String = ""
    
    @IBOutlet weak var newTopicTextField: UITextField!
    
    @IBOutlet weak var newTopicContentTextField: UITextView!
    
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.action = #selector(SendAction)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func SendAction() {
        
        if loginuser.isLogin
        {
//            http://localhost/SpectrumServer/API/NewTopic/?topic=test%20topic&content=test%20content&userID=1
            let base = "http://localhost/SpectrumServer/API/NewTopic/?"
            
            let argTopic = "topic="+self.newTopicTextField.text!
            let argTopicContent = "&content="+self.newTopicContentTextField.text!
            let argUserName = "&userName="+loginuser.username!
            let arg = argTopic + argTopicContent + argUserName
            let url = base + arg
            
            print(url)
            
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    DispatchQueue.main.async {
                        if result.result > 0{
                            self.performSegue(withIdentifier: "unwindSuccessSendNewTopic", sender: self)
                            print("success")
                        }else{
                            print("fails")
                            // to do // jump to the login page
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
