//
//  CaseViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

var casePublic: myCase? = nil

class CaseViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var Array = ["Hello", "World", "This is Burnie"]
    
    var categories = ["Case Studies","Life Cases"]
    
    var selectedCategory: String?
    var selectedCategoryRow: Int?
    
    @IBOutlet weak var caseNav: UINavigationItem!
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var caseTableView: UITableView!
    
    var data = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var CaseStudyData = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var LifeCaseData = ["LC_1_1","LC_2_1","LC_3_1","LC_4_1","LC_5_1","LC_6_1"]
    
    var currentCaseData: [myCase] = []
    
    var caseData = [
        myCase(
            caseID: "1",
            caseName: "Case 1",
            caseVideoName: "video_case_study_1",
            caseType: "1",
            caseCoverPic: "CS_1_1",
            teachersNote: [
                TeachersNote(noteID: "1", noteVideo: "", noteCover: "")
            ],
            questions: [
                Question(
                    questionID: "1",
                    question: "Considering Darrens behavioral problems and his history of antagonizing fellow students, should he be permitted to continue his presentation?",
                    options: [Option(optionID: "1",optionContent: "Yes, I should be permitted to continue his presentation. ",isSelect: false,isCorrect: true),
                              Option(optionID: "2",optionContent: "No, I should not be permitted to continue his presentation.",isSelect: false,isCorrect: false)],
                    explanation: "",
                    expanded: false),
                Question(
                    questionID: "2",
                    question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
                    options:[Option(optionID: "4",optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.", isSelect: false,isCorrect: false),
                             Option(optionID: "5",optionContent: "Sure, students should have at least on opportunity to try it.", isSelect: false,isCorrect: false),
                             Option(optionID: "6",optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.", isSelect: false,isCorrect: false)],
                    explanation: "",
                    expanded: false)
            ]),
        myCase(
            caseID: "2",
            caseName: "Case 2",
            caseVideoName: "video_case_study_2",
            caseType: "1",
            caseCoverPic: "LC_1_1",
            teachersNote: [
                TeachersNote(noteID: "2", noteVideo: "Teachersnote2.mp4", noteCover: "")
            ],
            questions: [
                Question(
                        questionID: "3",
                        question: "What would you do differently with Melissa’s third – period class?",
                        options: [Option(optionID: "7",optionContent: "Try the lab again the same way.",isSelect: false,isCorrect: false),
                                  Option(optionID: "8",optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",isSelect: false,isCorrect: false),
                                  Option(optionID: "9",optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",isSelect: false,isCorrect: false),],
                        explanation: "",
                        expanded: false),
                Question(
                        questionID: "4",
                        question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
                        options:[Option(optionID: "10",optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.", isSelect: false,isCorrect: false),
                                 Option(optionID: "11",optionContent: "Sure, students should have at least on opportunity to try it.", isSelect: false,isCorrect: false),
                                 Option(
                                    optionID: "12",
                                    optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.",
                                    isSelect: false,
                                    isCorrect: false)],
                        explanation: "",
                        expanded: false
                )
            ]),
        myCase(
            caseID: "3",
            caseName: "Case 3",
            caseVideoName: "video_case_study_1",
            caseType: "2",
            caseCoverPic: "LC_1_1",
            teachersNote: [
                TeachersNote(noteID: "2", noteVideo: "Teachersnote2.mp4", noteCover: "")
            ],
            questions: [
                Question(
                    questionID: "3",
                    question: "What would you do differently with Melissa’s third – period class?",
                    options: [Option(optionID: "7",optionContent: "Try the lab again the same way.",isSelect: false,isCorrect: false),
                              Option(optionID: "8",optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",isSelect: false,isCorrect: false),
                              Option(optionID: "9",optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",isSelect: false,isCorrect: false),],
                    explanation: "",
                    expanded: false),
                Question(
                    questionID: "4",
                    question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
                    options:[Option(optionID: "10",optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.", isSelect: false,isCorrect: false),
                             Option(optionID: "11",optionContent: "Sure, students should have at least on opportunity to try it.", isSelect: false,isCorrect: false),
                             Option(
                                optionID: "12",
                                optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.",
                                isSelect: false,
                                isCorrect: false)],
                    explanation: "",
                    expanded: false
                )
            ])
    ]
    
//    var caseArray = [CaseEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let caseArray =
//            [
//                myCase(caseID: "1", caseVideoName: "CS_1_1", caseType: "1", caseCoverPic: <#String#>)
//            ]
        
        createCategoryPicker()
        createToolBar()
        retrieveData(typeOfCase: "1")
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        caseTableView.dataSource = self
        caseTableView.delegate = self
        categoriesTextField.delegate = self
    }
    
    func createCategoryPicker()
    {
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoriesTextField.inputView = categoryPicker
    }
    func createToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CaseViewController.barButtonAction))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        categoriesTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func barButtonAction()
    {
        dismissKeyboard()
//        if selectedCategoryRow == 0
//        {
//            self.data = CaseStudyData
//        }
//        else if selectedCategoryRow == 1
//        {
//            self.data = LifeCaseData
//        }
        let selectedRow: Int = selectedCategoryRow!+1
        retrieveData(typeOfCase: selectedRow.description)
        caseTableView.reloadData()
        caseNav.title = selectedCategory
    }
    
    func dismissKeyboard()
    {
        self.categoriesTextField.resignFirstResponder()
        self.view.endEditing(true)
    }

    func retrieveData(typeOfCase: String)
    {
        self.currentCaseData.removeAll()
        for i in 0..<caseData.count
        {
            if(caseData[i].caseType == typeOfCase)
            {
                self.currentCaseData.append(caseData[i])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CaseViewController: UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath) as! myCell
//        let post = data[indexPath.row]
        let post = currentCaseData[indexPath.row].caseCoverPic
        cell.myCellImage.image = UIImage(named: post!)
        cell.myCellLabel.text = "Todo Case Study Life Experience"

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
        return currentCaseData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTheCaseSegue", sender: self)
        casePublic = self.currentCaseData[indexPath.row]
//        caseVideoPublic = self.currentCaseData[indexPath]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        selectedCategoryRow = row
        //categoriesTextField.text = selectedCategory
    }
}

