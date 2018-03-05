//
//  SuccessRegisterViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/4/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

struct RegisterResult: Decodable{
    var result: Int
}

class SuccessRegisterViewController: UIViewController {
    
    @IBOutlet weak var hintLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.backBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
        
        let url = "http://localhost/SpectrumServer/API/Register/signup/?username="+registerUser.username+"&password="+registerUser.userPassword+"&email="+registerUser.userEmail
        
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let result = try JSONDecoder().decode(RegisterResult.self, from: data)
                DispatchQueue.main.async {
                    if result.result>0{
                        self.navigationItem.title = "Sign Up"
                        self.hintLabel.text = "Sign up successful"
                    }else{
                        self.navigationItem.title = "Sign Up"
                        self.hintLabel.text = "Try again"
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
