//
//  TeamsViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/18/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
