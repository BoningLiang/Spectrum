//
//  ViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/2/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



