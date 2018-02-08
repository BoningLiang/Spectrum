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

class theCaseViewController: UIViewController {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var questionArray = [
        Question(
            questionID: "1",
            question: "What would you do differently with Melissa’s third – period class?",
            options:["Try the lab again the same way.", "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.","Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available."],
            expanded: false,
            isSelected: false,
            correctKeyIndex: 1,
            selectedKey: -1),
        Question(
            questionID: "2",
            question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
            options:["Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.", "Sure, students should have at least on opportunity to try it.","No, students are not able to understand critical thinking and apply in to real-world problems."],
            expanded: false,
            isSelected: false,
            correctKeyIndex: 0,
            selectedKey: -1)]
    
//    var questionEntity = [QuestionEntity]()
//    var optionEntity = [OptionEntity]()
    
    var selectIndexPath: IndexPath!
    
    @IBAction func playButtonAction(_ sender: Any)
    {
        if let path=Bundle.main.path(forResource:"video_1", ofType:"mp4")
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectIndexPath = IndexPath(row:-1, section:-1)
        let nib = UINib(nibName: "myHeaderView", bundle: nil)
        self.questionTableView.register(nib, forHeaderFooterViewReuseIdentifier: "myHeaderView")
        
        self.questionTableView.dataSource = self
        self.questionTableView.delegate = self
        self.questionTableView.estimatedRowHeight = 300
        self.questionTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension theCaseViewController: UITableViewDataSource, UITableViewDelegate, myHeaderViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray[section].options.count
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
        headerView.customInit(header: questionArray[section].question, section: section, delegate: self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell")
        cell?.textLabel?.text = questionArray[indexPath.section].options[indexPath.row]
        if(self.questionArray[indexPath.section].isSelected)
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
        return questionArray[section].question
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndexPath = indexPath
//        self.questionArray[indexPath.section].expanded = !self.questionArray[indexPath.section].expanded
        tableView.beginUpdates()
        tableView.reloadSections([indexPath.section], with: .automatic)
        tableView.endUpdates()
    }
    
    func toggleSection(header: myHeaderView, section: Int) {
//        self.questionArray[section].expanded = !self.questionArray[section].expanded
        self.questionTableView.beginUpdates()
        self.questionTableView.reloadSections([section], with: .automatic)
        self.questionTableView.endUpdates()
    }
    
}
