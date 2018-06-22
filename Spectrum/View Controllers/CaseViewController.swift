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
    
//    var caseEntity = [CaseEntity]()
    
    @IBOutlet weak var caseNav: UINavigationItem!
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var caseTableView: UITableView!
    
    var data = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var CaseStudyData = ["CS_1_1","CS_2_1","CS_3_1","CS_4_1","CS_5_1","CS_6_1","CS_7_1","CS_8_1","CS_9_1"]
    
    var LifeCaseData = ["LC_1_1","LC_2_1","LC_3_1","LC_4_1","LC_5_1","LC_6_1"]
    
    var currentCaseData: [myCase] = []
    
//    var caseDataFromCoreData: [myCase] = []
    var caseDataFromAUServer: [myCase] = []
    
    var caseDataFromServerSimplify: [String: String] = [:]
    
    var activityIndicator = UIActivityIndicatorView()
    
    var caseDataFromServer:[myCase] = []
    
    var caseData:[myCase] = []
    
//    var caseArray = [CaseEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        initData()
        
        createCategoryPicker()
        createToolBar()
        retrieveData(caseChapter: "1")
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        caseTableView.dataSource = self
        caseTableView.delegate = self
        categoriesTextField.delegate = self

    }
    
    func initData()
    {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        ServerController.requestData(withRequest: loginuser.username!) { (results:[myCase]?) in
            if let resultCaseData = results {
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.caseDataFromServer = resultCaseData
//                        self.caseDataFromCoreData = CoreDataController.getAllCasesFromCoreData()
                        self.retrieveData(caseChapter: "1")
                        self.caseTableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    })
                }
            }
        }
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
        retrieveData(caseChapter: selectedRow.description)
        caseTableView.reloadData()
        caseNav.title = selectedCategory
    }
    
    func dismissKeyboard()
    {
        self.categoriesTextField.resignFirstResponder()
        self.view.endEditing(true)
    }

    func retrieveData(caseChapter: String)
    {
        self.currentCaseData.removeAll()
        for i in 0..<caseDataFromServer.count
        {
            if(caseDataFromServer[i].caseChapter == caseChapter)
            {
                self.currentCaseData.append(caseDataFromServer[i])
            }
        }
    }
    
    
    
    @IBAction func loginUnwind(_ sender: SWRevealViewControllerSeguePushController)
    {
        
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
        let post = currentCaseData[indexPath.row].caseCoverPic
        cell.myCellImage.image = UIImage(named: post!)
        cell.myCellLabel.text = currentCaseData[indexPath.row].caseName
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
        return currentCaseData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTheCaseSegue", sender: self)
        casePublic = self.currentCaseData[indexPath.row]
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

