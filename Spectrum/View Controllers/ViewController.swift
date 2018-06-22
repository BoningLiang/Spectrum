//
//  ViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/2/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import CoreData

//let baseUrl = "http://localhost"
//let baseUrl = "http://spectrum.free.ngrok.cc"
let baseUrl = "http://auburn.edu/~bzl0048"

class ViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        let url = "http://wp.auburn.edu/sustainability/wp-content/uploads/2014/07/AU-wordmark.png"
        
        BLCache.downloadImage(url: URL(string: url)!) { (image, error) in
            DispatchQueue.main.async{
                self.testImageView.image = image
            }
        }
        
        
        let fetchLoginSessionRequest:NSFetchRequest<LoginSessionEntity> = LoginSessionEntity.fetchRequest()
        
        do {
            let loginSessionEntity = try CoreDataService.context.fetch(fetchLoginSessionRequest)
            if loginSessionEntity.count>0 {
                
                print("ViewController: ViewDidLoad(): main page: ")
                
                for i in 0..<loginSessionEntity.count{
                    print("username ",i," ", loginSessionEntity[i].username ?? "username is null")
                    print("isLogin ",i," ", loginSessionEntity[i].isLogin)
                    print("password ",i," ", loginSessionEntity[i].password ?? "password is null")
                }
                
                let lastIndex = loginSessionEntity.count-1
                
                loginuser.username = loginSessionEntity[lastIndex].username
                loginuser.isLogin = loginSessionEntity[lastIndex].isLogin
                loginuser.userPassword = loginSessionEntity[lastIndex].password
            }
        } catch {
            print("ViewController: viewDidLoad(): error")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



