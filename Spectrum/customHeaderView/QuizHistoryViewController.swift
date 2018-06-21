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
//[{"quizID":"1","userID":"1","caseID":"1","attemptTime":"2018-06-08 14:04:46"}
class GetAttemptsResult: Decodable{
    var quizID: String?
    var userID: String?
    var caseID: String?
    var attemptTime: String?
    
    init() {
        
    }
}

class QuizHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var getAttemptsData: [GetAttemptsResult] = [GetAttemptsResult()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        let url = baseUrl+"/SpectrumServer/API/GetAttempts/?username="+registerUser.username+"&caseID="+(casePublic?.caseID)!
        
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let result = try JSONDecoder().decode([GetAttemptsResult].self, from: data)
                DispatchQueue.main.async {
                    self.getAttemptsData = result
                    self.tableView.reloadData()
                }
            }catch{
                do{
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    print("BL Error: ", result)
                }catch{
                    print("QuizHistroyViewController 2: ", error.localizedDescription)
                }
            }
        }
        task.resume()
        
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
//        cell.attemptNumberLabel.text = "#" + "1"
//        cell.gradeLabel.text = "Submitted: "
//        cell.attemptTimeLabel.text = "Mon Mar 2019 19:20:00"
        
        cell.attemptTimeLabel.text = "#" + indexPath.row.description
        cell.gradeLabel.alpha = 0
        cell.attemptTimeLabel.text = self.getAttemptsData[indexPath.row].attemptTime
        return cell
    }
}
