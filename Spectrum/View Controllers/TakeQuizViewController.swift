//
//  TakeQuizViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/19/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class TakeQuizViewController: UIViewController {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var selectIndexPath: IndexPath!
    
    var questionArray2: [Question] = []
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    @IBAction func submitButtonAction(_ sender: Any) {
        self.SubmitAction()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.questionArray2.removeAll()
        self.questionArray2 = (casePublic?.questions)!
        
        selectIndexPath = IndexPath(row:-1, section:-1)
        let nib = UINib(nibName: "myHeaderView", bundle: nil)
        self.questionTableView.register(nib, forHeaderFooterViewReuseIdentifier: "myHeaderView")
        
        self.questionTableView.dataSource = self
        self.questionTableView.delegate = self
        self.questionTableView.estimatedRowHeight = 300
        self.questionTableView.rowHeight = UITableViewAutomaticDimension
        
//        submitButton.action = #selector(self.SubmitAction)
        print("TakeQuizViewController")
        // Do any additional setup after loading the view.
    }

    func SubmitAction(){
        questionArrayPublic = self.questionArray2
        print("SubmitAction")
        if (loginuser.isLogin)
        {
            //
            let base = baseUrl+"/SpectrumServer/API/NewAttempt?"
            var _url: String = ""
            var count = 0
            let parUserName = "userName=" + loginuser.username!
            let parCaseID = "&caseID=" + (casePublic?.caseID)!
            for singleQuestion in self.questionArray2
            {
                for singleOption in singleQuestion.options
                {
                    let parOptionID = "&optionID" + count.description + "=" + singleOption.optionID
                    let parOptionIsSelect = "&isSelect" + count.description + "=" + singleOption.isSelect.description
                    let par = parOptionID + parOptionIsSelect
                    _url = _url + par
                    count = count + 1
                }
            }
            
            let url = base + parUserName + parCaseID + _url
            print(url)
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    print(data)
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    DispatchQueue.main.async {
                        if(result.result! > 0)
                        {
                            self.performSegue(withIdentifier: "unwindSubmitAttemptSegue", sender: self)
                            print("TakeQuizViewController: SubmitAction(): success submit new attempt quiz")
                        }
                        else
                        {
                            print("TakeQuizViewController: SubmitAction(): fail to submit new attempt")
                        }
                    }
                }catch{
                    print("TakeQuizViewController: SubmitAction(): ", error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func submitNewAttempt() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TakeQuizViewController: UITableViewDataSource, UITableViewDelegate, myHeaderViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionArray2.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray2[section].options.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if(questionArray[indexPath.section].expanded)
    //        {
    //            return 44
    //        }else {
    //            return 0
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myHeaderView") as! myHeaderView
        headerView.customInit(header: questionArray2[section].question, section: section, delegate: self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell")
        cell?.textLabel?.text = questionArray2[indexPath.section].options[indexPath.row].optionContent
        if(self.questionArray2[indexPath.section].options[indexPath.row].isSelect)
        {
            cell?.accessoryType = (indexPath == selectIndexPath) ? .checkmark:.checkmark
        }
        else
        {
            cell?.accessoryType = (indexPath == selectIndexPath) ? .checkmark:.none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return questionArray2[section].question
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndexPath = indexPath
        tableView.beginUpdates()
        if self.questionArray2[indexPath.section].options[indexPath.row].isSelect
        {
            self.questionArray2[indexPath.section].options[indexPath.row].isSelect = false
        }
        else
        {
            self.questionArray2[indexPath.section].options[indexPath.row].isSelect = true
            for c in 0..<self.questionArray2[indexPath.section].options.count
            {
                if c != indexPath.row
                {
                    self.questionArray2[indexPath.section].options[c].isSelect = false
                    print(c.description + self.questionArray2[indexPath.section].options[c].isSelect.description)
                }
            }
        }
        //        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadSections([indexPath.section], with: .automatic)
        tableView.endUpdates()
    }
    
    func toggleSection(header: myHeaderView, section: Int) {
        self.questionTableView.beginUpdates()
        self.questionTableView.reloadSections([section], with: .automatic)
        self.questionTableView.endUpdates()
    }
}
