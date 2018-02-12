//
//  CaseViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

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
    
//    var caseArray = [CaseEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let caseArray =
            [
                myCase(caseID: "1", caseVideoName: "CS_1_1", caseSection: "1")
            ]
        
        createCategoryPicker()
        createToolBar()
        
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
        if selectedCategoryRow == 0
        {
            self.data = CaseStudyData
        }
        else if selectedCategoryRow == 1
        {
            self.data = LifeCaseData
        }
        caseTableView.reloadData()
        caseNav.title = selectedCategory
    }
    
    func dismissKeyboard()
    {
        self.categoriesTextField.resignFirstResponder()
        self.view.endEditing(true)
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
        let post = data[indexPath.row]
        cell.myCellImage.image = UIImage(named: post)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTheCaseSegue", sender: self)
        
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

