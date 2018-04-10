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
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.action = #selector(SendAction)
        self.navItem.leftBarButtonItem?.title = "Cancel"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navItem.leftBarButtonItem?.title = "Cancel"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func encodeEmoji(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func decodeEmoji(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    
    @objc func SendAction() {
        
        if loginuser.isLogin
        {
            let base = baseUrl+"/SpectrumServer/API/NewTopic/?"
            
            var newTopicTitleString = self.newTopicTextField.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            newTopicTitleString = encodeEmoji(newTopicTitleString)
            
            var newTopicContentString = self.newTopicContentTextField.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            newTopicContentString = encodeEmoji(newTopicContentString)
            
            if newTopicTitleString.isEmpty || newTopicContentString.isEmpty {
                print("NewTopicViewController: SendAction(): Missing title or content.")
            }
            else{
                let argTopicTitle = "topic=" + newTopicTitleString
                let argTopicContent = "&content=" + newTopicContentString
                let argUserName = "&userName="+loginuser.username!.trimmingCharacters(in: NSCharacterSet.whitespaces)
                
                let arg = argTopicTitle + argTopicContent + argUserName
                var url = base + arg
                
                url = url.replacingOccurrences(of: " ", with: "%20")
                url = url.replacingOccurrences(of: "\\", with: "%5C")
//                print(url)
                let urlURL:URL = URL(string: url)!
                let request = URLRequest(url: urlURL)
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
}
