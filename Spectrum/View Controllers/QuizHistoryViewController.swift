//
//  QuizHistoryViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/19/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class resultAttemptSummary: Decodable{
    var attemptID: String
    var grade: String
    var time: String
}

class QuizHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QuizHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizAttemptsCell", for: indexPath) as! QuizAttemptsTableViewCell
        cell.attemptNumberLabel.text = "#" + "1"
        cell.gradeLabel.text = "Submitted: "
        cell.attemptTimeLabel.text = "Mon Mar 2019 19:20:00"
        return cell
    }
}
