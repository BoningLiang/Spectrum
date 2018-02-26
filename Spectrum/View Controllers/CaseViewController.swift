//
//  CaseViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import CoreData

var casePublic: myCase? = nil

class CaseViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var Array = ["Hello", "World", "This is Burnie"]
    
    var categories = ["Case Studies","Life Cases"]
    
    var selectedCategory: String?
    var selectedCategoryRow: Int?
    
    var caseEntity = [CaseEntity]()
    
    @IBOutlet weak var caseNav: UINavigationItem!
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var caseTableView: UITableView!
    
    var data = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var CaseStudyData = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var LifeCaseData = ["LC_1_1","LC_2_1","LC_3_1","LC_4_1","LC_5_1","LC_6_1"]
    
    var currentCaseData: [myCase] = []
    
    var caseDataFromCoreData: [myCase] = []
    var caseDataFromAUServer: [myCase] = []
    
    var caseDataFromServerSimplify: [String: String] = [:]
    
    var activityIndicator = UIActivityIndicatorView()
    
    var caseDataFromServer:[myCase] = []
//    var caseDataFromServer = [
//        myCase(
//            caseID: "1",
//            caseName: "Case study 10: Oppositional Defiant Disorder",
//            caseDescription: "The teacher does not know how to handle the student who has oppositional defiant disorder. In this case, the teacher does not pay much attention to Willy. When Willy's behavior problems appear, the teacher doesn't know how to help Willy and solve the problem by herself. She instead sends him to the positive behavior teacher to correct his behavior. For this scenario, I would like for teachers to be aware of this kind of situation and be encouraged to learn this disorder.",
//            caseVideoName: "case_MZL_10",
//            caseType: "1",
//            caseCoverPic: "case_video_cover_10",
//            caseVideoScreenshot: "case_video_screenshot_10",
//            teachersNote: [
//                TeachersNote(noteID: "1", noteVideo: "case_MZL_10_TN", noteCover: "teachers_note_cover_10")
//            ],
//            questions: [
//                Question(
//                    questionID: "1",
//                    question: "Considering Willy's behavioral problems, should he be immediately sent to the Positive Behavior teacher?",
//                    options: [Option(optionID: "1",optionContent: "Yes, Willy should be sent to the Positive Behavior teacher. ",isSelect: false,isCorrect: false),
//                              Option(optionID: "2",optionContent: "No, Willy shouldn't be sent to the Positive Behavior teacher.",isSelect: false,isCorrect: true)],
//                    explanation: "One successful example shows that teachers should pay attention and show respect to students who have oppositional defiant disorder. Because most of time students seek attention from teachers. Sending them to the positive behavior teachers will hurt their confidence and self-esteem. In this case, teachers shouldn't send them immediately to special department when they have behavior problems. And teachers also should know when to show much attention and less attention. For example, show less attention when they don't improve their behavior.",
//                    expanded: false)
//            ]),
//        myCase(
//            caseID: "2",
//            caseName: "Case study 11: Extroverted Student",
//            caseDescription: "Jaden is an eight year old in the second grade classroom. His misbehaviors are mostly because of speaking out of turn. The teacher does not know how to properly deal with this situation that Jaden talks out of turn when she is not asking for responses. In this case, when Jaden suddenly stands up and gives his answer in class, the teacher makes him move his clip down after class to punish him. However, it leads to a negetive result that Jaden becomes a lot quieter and lacks motivation to do his work.",
//            caseVideoName: "case_CR_11",
//            caseType: "1",
//            caseCoverPic: "case_video_cover_11",
//            caseVideoScreenshot: "case_video_screenshot_11",
//            teachersNote: [
//                TeachersNote(noteID: "2", noteVideo: "case_CR_11_TN", noteCover: "teachers_note_cover_11")
//            ],
//            questions: [
//                Question(
//                    questionID: "3",
//                    question: "Considering Jaden's behavioral problems, is there any better way for the teacher to handle this? ",
//                    options: [Option(optionID: "7",optionContent: "Yes, the teacher should give more mixed responses style questions to allow Jaden to voice his ideas without distracting others.",isSelect: false,isCorrect: true),
//                              Option(optionID: "8",optionContent: "No. Jaden should take his punishment to move his clip down.",isSelect: false,isCorrect: false)],
//                    explanation: "It seems that Jaden never has enough opportunity to verbalize what he wants to say and this is why he talks out of turn. Teachers could implement more mixed responses style questions in the class which will lead to fewer disruptions made by students like Jaden. If the teacher uses this approach, Jaden will have more opportunities to voice his opinions and ideas in class.",
//                    expanded: false)
//            ]),
//        myCase(
//            caseID: "3",
//            caseName: "Case 3",
//            caseDescription: "todo",
//            caseVideoName: "video_case_study_1",
//            caseType: "2",
//            caseCoverPic: "LC_1_1",
//            caseVideoScreenshot: "LC_1_1",
//            teachersNote: [
//                TeachersNote(noteID: "2", noteVideo: "Teachersnote2.mp4", noteCover: "")
//            ],
//            questions: [
//                Question(
//                    questionID: "3",
//                    question: "What would you do differently with Melissa’s third – period class?",
//                    options: [Option(optionID: "7",optionContent: "Try the lab again the same way.",isSelect: false,isCorrect: false),
//                              Option(optionID: "8",optionContent: "Have the lab at a later date so you can explain to the students how to us critical thinking to solve a problem.",isSelect: false,isCorrect: false),
//                              Option(optionID: "9",optionContent: "Recreate the lab worksheet that gives the students step by step instructions and has the answer readily available.",isSelect: false,isCorrect: false),],
//                    explanation: "",
//                    expanded: false),
//                Question(
//                    questionID: "4",
//                    question: "Do you agree with Melissa’s initial idea that high school biology students should have opportunities to solve real-world problems and apply concepts?",
//                    options:[Option(optionID: "10",optionContent: "Yes, problem solving teaches students to develop their own creativity, thinking skills, and communicative skills.", isSelect: false,isCorrect: false),
//                             Option(optionID: "11",optionContent: "Sure, students should have at least on opportunity to try it.", isSelect: false,isCorrect: false),
//                             Option(
//                                optionID: "12",
//                                optionContent: "No, students are not able to understand critical thinking and apply in to real-world problems.",
//                                isSelect: false,
//                                isCorrect: false)],
//                    explanation: "",
//                    expanded: false
//                )
//            ])
//    ]
    
    var caseData = [
        myCase(
            caseID: "1",
            caseName: "Case study 10: Oppositional Defiant Disorder",
            caseDescription: "The teacher does not know how to handle the student who has oppositional defiant disorder. In this case, the teacher does not pay much attention to Willy. When Willy's behavior problems appear, the teacher doesn't know how to help Willy and solve the problem by herself. She instead sends him to the positive behavior teacher to correct his behavior. For this scenario, I would like for teachers to be aware of this kind of situation and be encouraged to learn this disorder.",
            caseVideoName: "case_MZL_10",
            caseType: "1",
            caseCoverPic: "case_video_cover_10",
            caseVideoScreenshot: "case_video_screenshot_10",
            teachersNote: [
                TeachersNote(noteID: "1", noteVideo: "case_MZL_10_TN", noteCover: "teachers_note_cover_10")
            ],
            questions: [
                Question(
                    questionID: "1",
                    question: "Considering Willy's behavioral problems, should he be immediately sent to the Positive Behavior teacher?",
                    options: [Option(optionID: "1",optionContent: "Yes, Willy should be sent to the Positive Behavior teacher. ",isSelect: false,isCorrect: false),
                              Option(optionID: "2",optionContent: "No, Willy shouldn't be sent to the Positive Behavior teacher.",isSelect: false,isCorrect: true)],
                    explanation: "One successful example shows that teachers should pay attention and show respect to students who have oppositional defiant disorder. Because most of time students seek attention from teachers. Sending them to the positive behavior teachers will hurt their confidence and self-esteem. In this case, teachers shouldn't send them immediately to special department when they have behavior problems. And teachers also should know when to show much attention and less attention. For example, show less attention when they don't improve their behavior.",
                    expanded: false)
            ]),
        myCase(
            caseID: "2",
            caseName: "Case study 11: Extroverted Student",
            caseDescription: "Jaden is an eight year old in the second grade classroom. His misbehaviors are mostly because of speaking out of turn. The teacher does not know how to properly deal with this situation that Jaden talks out of turn when she is not asking for responses. In this case, when Jaden suddenly stands up and gives his answer in class, the teacher makes him move his clip down after class to punish him. However, it leads to a negetive result that Jaden becomes a lot quieter and lacks motivation to do his work.",
            caseVideoName: "case_CR_11",
            caseType: "1",
            caseCoverPic: "case_video_cover_11",
            caseVideoScreenshot: "case_video_screenshot_11",
            teachersNote: [
                TeachersNote(noteID: "2", noteVideo: "case_CR_11_TN", noteCover: "teachers_note_cover_11")
            ],
            questions: [
                Question(
                        questionID: "3",
                        question: "Considering Jaden's behavioral problems, is there any better way for the teacher to handle this? ",
                        options: [Option(optionID: "7",optionContent: "Yes, the teacher should give more mixed responses style questions to allow Jaden to voice his ideas without distracting others.",isSelect: false,isCorrect: true),
                                  Option(optionID: "8",optionContent: "No. Jaden should take his punishment to move his clip down.",isSelect: false,isCorrect: false)],
                        explanation: "It seems that Jaden never has enough opportunity to verbalize what he wants to say and this is why he talks out of turn. Teachers could implement more mixed responses style questions in the class which will lead to fewer disruptions made by students like Jaden. If the teacher uses this approach, Jaden will have more opportunities to voice his opinions and ideas in class.",
                        expanded: false)
            ]),
        myCase(
            caseID: "3",
            caseName: "Case 3",
            caseDescription: "todo",
            caseVideoName: "video_case_study_1",
            caseType: "2",
            caseCoverPic: "LC_1_1",
            caseVideoScreenshot: "LC_1_1",
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
        initActivityIndicator()
        initData()
        
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
        
//        for theCaseDataFromServer in self.caseDataFromServer
//        {
//            theCaseDataFromServer.insertDataToCoreData()
//        }
        
//        let resultCaseEntities:[CaseEntity] = CoreDataController.selectAllCaseEntity()
//
//        if resultCaseEntities.isEmpty {
//
//        }
//        else{
//            for resultCaseEntity in resultCaseEntities
//            {
//                print(resultCaseEntity.caseName)
//                print(resultCaseEntity.caseID)
//            }
//        }
        
//        let resultCaseEntities:[CaseEntity] = CoreDataController.selectCaseWithID(id: "1")
//        
//        if resultCaseEntities.isEmpty {
//            
//        }
//        else{
//            for resultCaseEntity in resultCaseEntities
//            {
//                print(resultCaseEntity.caseName)
//                print(resultCaseEntity.caseID)
//            }
//        }
        
        
        
        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        print(urls[urls.count-1] as URL)
    }
    
    func initData()
    {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        ServerController.requestData(withRequest: "sample2.json") { (results:[myCase]?) in
            if let resultCaseData = results {
                self.caseDataFromServer = resultCaseData
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                        UIApplication.shared.endIgnoringInteractionEvents()

                        self.retrieveData(typeOfCase: "1")
                        self.caseTableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    })
                }
            }
        }
//        self.caseDataFromAUServer = self.retrieveAndUpdateDataFromServer()
//        self.caseDataFromCoreData = myCase.getAllCasesFromCoreData()
    }
    
    func initActivityIndicator()
    {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(activityIndicator)
    }
    
    func retrieveAndUpdateDataFromServer() -> [myCase]
    {
        
        return [myCase]()
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
        for i in 0..<caseDataFromServer.count
        {
            if(caseDataFromServer[i].caseType == typeOfCase)
            {
                self.currentCaseData.append(caseDataFromServer[i])
            }
        }
    }
    
//    func fetchCoreData() -> Bool
//    {
//        print("fetching coredata")
//        let fetchRequest: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
//        do{
//            let caseEntity = try CoreDataService.context.fetch(fetchRequest)
//            self.caseEntity = caseEntity
//        }catch{
//            print("Fetch request fails")
//        }
//        for i in 0..<caseEntity.count
//        {
//            print(self.caseEntity[i].caseName)
//        }
//        print("fetching coredata finished")
//        return false
//    }
    
//    func saveDataIntoCoreData(dataToSave: [myCase])
//    {
//        let newCaseEntity: CaseEntity = CaseEntity()
//        let caseDataFS = caseDataFromServer[0]
//        newCaseEntity.caseID = caseDataFS.caseID
//        newCaseEntity.caseDescription = caseDataFS.caseDescription
//        newCaseEntity.caseCoverPic = caseDataFS.caseCoverPic
//        newCaseEntity.caseName = caseDataFS.caseName
//        newCaseEntity.caseSection = caseDataFS.caseType
//        newCaseEntity.caseType = caseDataFS.caseType
//        newCaseEntity.caseVideoName = caseDataFS.caseVideoName
//        newCaseEntity.caseVideoScreenshot = caseDataFS.caseVideoScreenshot
//
////        self.caseEntity.append(<#T##newElement: CaseEntity##CaseEntity#>)
//    }
    
    
//    func insertData() -> Bool
//    {
//        return false
//    }
//    
//    func updateData() -> Bool
//    {
//        return false
//    }
//    
//    func deleteData() -> Bool
//    {
//        return false
//    }
//    
//    func selectData(data: AnyObject) -> [AnyObject]
//    {
//        let returnObject: [AnyObject] = []
//        return mc
//    }
    
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
//        cell.myCellLabel.text = "Todo Case Study Life Experience"
//        print("hello label")
        cell.myCellLabel.text = currentCaseData[indexPath.row].caseName
//        print("hello label 1")
//        print(currentCaseData[indexPath.row])
//        print("hello label 2")

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

