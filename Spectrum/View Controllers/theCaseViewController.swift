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
    
//    var questionArray3 = [
//        Question(
//            questionID: "1",
//            question: "What would you do differently with Melissa’s third – period class?",
//            options: [
//                Option(
//                    optionID: "1",
//                    optionContent: "Try the lab again the same way.",
//                    isSelect: false,
//                    isCorrect: true),
//                Option(
//                    optionID: "2",
//                    optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",
//                    isSelect: false,
//                    isCorrect: false),
//                Option(
//                    optionID: "3",
//                    optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",
//                    isSelect: false,
//                    isCorrect: false),],
//            explanation: "explanation sample 1",
//            expanded: false),
//        Question(
//            questionID: "2",
//            question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
//            options:[
//                Option(
//                    optionID: "4",
//                    optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.",
//                    isSelect: false,
//                    isCorrect: false),
//                Option(
//                    optionID: "5",
//                    optionContent: "Sure, students should have at least on opportunity to try it.",
//                    isSelect: false,
//                    isCorrect: true),
//                Option(
//                    optionID: "6",
//                    optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.",
//                    isSelect: false,
//                    isCorrect: false)],
//            explanation: "explanation sample 2",
//            expanded: false)
//    ]
//
//    var questionArray2 = [
//        Question(
//            questionID: "1",
//            question: "What would you do differently with Melissa’s third – period class?",
//            options: [
//                Option(
//                    optionID: "1",
//                    optionContent: "Try the lab again the same way.",
//                    isSelect: false,
//                    isCorrect: true),
//                Option(
//                    optionID: "2",
//                    optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",
//                    isSelect: false,
//                    isCorrect: false),
//                Option(
//                    optionID: "3",
//                    optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",
//                    isSelect: false,
//                    isCorrect: false),],
//            explanation: "explanation sample 1",
//            expanded: false)
//    ]
    
    
    
//    var questionEntity = [QuestionEntity]()
//    var optionEntity = [OptionEntity]()
    
    var selectIndexPath: IndexPath!
    
    @IBAction func playButtonAction(_ sender: Any)
    {
        var videoName = casePublic!.caseVideoName
        if (videoName?.endsWith(string: ".mp4"))! {
            // do nothing
        }else{
            videoName = videoName! + ".mp4"
        }
        if let videoURL = URL(string: baseVideoURL + videoName!)
//        if let path=Bundle.main.path(forResource: casePublic!.caseVideoName, ofType:"mp4")
        {
            let video = AVPlayer(url: videoURL)
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
            {
                video.play()
            })
        }
    }
    
    
    
    @IBAction func aboutCaseButtonAction(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoCoverImage.image = UIImage(named: (casePublic?.caseVideoScreenshot)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TeachersNoteButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "TeachersNoteSegue", sender: self)
    }
    
    @IBAction func AttemptHistoryButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "quizHistorySegue", sender: self)
    }
    
    @IBAction func TakeQuizButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "takeQuizSegue", sender: self)
    }
    
    @IBAction func unwindSegueSubmitAttemptQuiz(_ sender: UIStoryboardSegue) {
        
    }
    
}

extension String{
    func endsWith(string: String) -> Bool{
        return self.hasSuffix(string)
    }
}
