//
//  checkAnsViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/19/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit



class checkAnsViewController: UIViewController {

    var questionArray: [Question] = []
    var currentQuestionIndex: Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explanationLabel: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var checkNextQuestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.questionArray = questionArrayPublic!
        questionLabel.text = self.questionArray[0].question
        explanationLabel.text = self.questionArray[0].explanation
        resultLabel.text = "Your Answer: Correct!"
        resultLabel.textColor = UIColor.green
        for i in 0..<self.questionArray[0].options.count
        {
            if(self.questionArray[0].options[i].isSelect != self.questionArray[0].options[i].isCorrect)
            {
                resultLabel.text = "Your Answer: Wrong!"
                resultLabel.textColor = UIColor.red
                break
            }
        }
        if(self.questionArray.count>1)
        {
            self.checkNextQuestionButton.isHidden = false
        }
        else
        {
            self.checkNextQuestionButton.isHidden = true
        }
    }
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
