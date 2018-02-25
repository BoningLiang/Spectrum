//
//  theCaseViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import AVKit
import CoreData

var questionArrayPublic: [Question]? = nil
var caseVideoPublic: String = ""

class theCaseViewController: UIViewController {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    @IBOutlet weak var videoCoverImage: UIImageView!
    
    
    //var questionArray2: [Question] = []
    
    var questionArray3 = [
        Question(
            questionID: "1",
            question: "What would you do differently with Melissa’s third – period class?",
            options: [
                Option(
                    optionID: "1",
                    optionContent: "Try the lab again the same way.",
                    isSelect: false,
                    isCorrect: true),
                Option(
                    optionID: "2",
                    optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",
                    isSelect: false,
                    isCorrect: false),
                Option(
                    optionID: "3",
                    optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",
                    isSelect: false,
                    isCorrect: false),],
            explanation: "explanation sample 1",
            expanded: false),
        Question(
            questionID: "2",
            question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
            options:[
                Option(
                    optionID: "4",
                    optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.",
                    isSelect: false,
                    isCorrect: false),
                Option(
                    optionID: "5",
                    optionContent: "Sure, students should have at least on opportunity to try it.",
                    isSelect: false,
                    isCorrect: true),
                Option(
                    optionID: "6",
                    optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.",
                    isSelect: false,
                    isCorrect: false)],
            explanation: "explanation sample 2",
            expanded: false)
    ]
    
    var questionArray2 = [
        Question(
            questionID: "1",
            question: "What would you do differently with Melissa’s third – period class?",
            options: [
                Option(
                    optionID: "1",
                    optionContent: "Try the lab again the same way.",
                    isSelect: false,
                    isCorrect: true),
                Option(
                    optionID: "2",
                    optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",
                    isSelect: false,
                    isCorrect: false),
                Option(
                    optionID: "3",
                    optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",
                    isSelect: false,
                    isCorrect: false),],
            explanation: "explanation sample 1",
            expanded: false)
    ]
    
    
    
//    var questionEntity = [QuestionEntity]()
//    var optionEntity = [OptionEntity]()
    
    var selectIndexPath: IndexPath!
    
    @IBAction func playButtonAction(_ sender: Any)
    {
        if let path=Bundle.main.path(forResource: casePublic!.caseVideoName, ofType:"mp4")
        {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
            {
                video.play()
            })
        }
    }
    
    @IBAction func checkAnswerAction(_ sender: Any) {
        questionArrayPublic = self.questionArray2
    }
    
    @IBAction func aboutCaseButtonAction(_ sender: Any) {
        
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
        
        self.videoCoverImage.image = UIImage(named: (casePublic?.caseVideoScreenshot)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension theCaseViewController: UITableViewDataSource, UITableViewDelegate, myHeaderViewDelegate
{
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
