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
    
    @IBOutlet weak var firstQuestionButton: UIButton!
    
    @IBOutlet weak var previousQuestionButton: UIButton!
    
    @IBOutlet weak var lastQuestionButton: UIButton!
    
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
            self.firstQuestionButton.isHidden = false
            self.previousQuestionButton.isHidden = false
            self.lastQuestionButton.isHidden = false
            
            self.checkNextQuestionButton.isEnabled = true
            self.firstQuestionButton.isEnabled = false
            self.previousQuestionButton.isEnabled = false
            self.lastQuestionButton.isEnabled = true
        }
        else
        {
            self.checkNextQuestionButton.isHidden = true
            self.firstQuestionButton.isHidden = true
            self.previousQuestionButton.isHidden = true
            self.lastQuestionButton.isHidden = true
        }
    }
    
    @IBAction func firstButtonAction(_ sender: Any) {
        loadData(question: self.questionArray.first!)
        self.previousQuestionButton.isEnabled = true
        self.firstQuestionButton.isEnabled = true
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        loadData(question: self.questionArray[self.currentQuestionIndex-1])
        self.currentQuestionIndex = self.currentQuestionIndex - 1
        if(currentQuestionIndex==0)
        {
            self.firstQuestionButton.isEnabled = false
            self.previousQuestionButton.isEnabled = false
        }
        else
        {
            self.firstQuestionButton.isEnabled = true
            self.previousQuestionButton.isEnabled = true
        }
        if(currentQuestionIndex < self.questionArray.count-1)
        {
            self.checkNextQuestionButton.isEnabled = true
            self.lastQuestionButton.isEnabled = true
        }
    }
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        loadData(question: self.questionArray[currentQuestionIndex+1])
        self.currentQuestionIndex = self.currentQuestionIndex + 1
        if(currentQuestionIndex == self.questionArray.count-1)
        {
            self.lastQuestionButton.isEnabled = false
            self.checkNextQuestionButton.isEnabled = false
        }
        else
        {
            self.checkNextQuestionButton.isEnabled = true
            self.lastQuestionButton.isEnabled = true
        }
        if(currentQuestionIndex>0)
        {
            self.firstQuestionButton.isEnabled = true
            self.previousQuestionButton.isEnabled = true
        }
    }
    
    @IBAction func lastButtonAction(_ sender: Any) {
        loadData(question: self.questionArray.last!)
        self.lastQuestionButton.isEnabled = true
        self.checkNextQuestionButton.isEnabled = true
    }
    
    func loadData(question: Question)
    {
        questionLabel.text = question.question
        explanationLabel.text = question.explanation
        resultLabel.text = "Your Answer: Correct!"
        resultLabel.textColor = UIColor.green
        for i in 0..<question.options.count
        {
            if(question.options[i].isSelect != question.options[i].isCorrect)
            {
                resultLabel.text = "Your Answer: Wrong!"
                resultLabel.textColor = UIColor.red
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
