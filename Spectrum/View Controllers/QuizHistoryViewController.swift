//
//  QuizHistoryViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/19/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class QuizHistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QuizHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizAttemptsCell", for: indexPath) as! QuizAttemptsTableViewCell
        
        return cell
    }
}
