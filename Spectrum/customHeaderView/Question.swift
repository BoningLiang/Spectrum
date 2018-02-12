//
//  Section.swift
//  Spectrum
//
//  Created by Boning Liang on 2/5/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation
import CoreData

struct Question {
    var questionID:String!
    var question:String!
    var options:[String]!
    var expanded: Bool!
    var isSelected: Bool!
    var correctKeyIndex: Int
    var selectedKey: Int
//    var outCaseID: String!
    var questionEntity = [QuestionEntity]()
    var optionEntity = [OptionEntity]()
    
    
    init(questionID: String, question: String, options: [String], expanded: Bool, isSelected: Bool, correctKeyIndex: Int, selectedKey: Int) {
        self.questionID = questionID
        self.question = question
        self.options = options
        self.expanded = expanded
        self.isSelected = isSelected
        self.correctKeyIndex = correctKeyIndex // begins with 0
        self.selectedKey = selectedKey
        
//        // QuestionEntity
//        let questionEntity = QuestionEntity(context: CoreDataService.context)
//        questionEntity.questionID = self.questionID
//        questionEntity.questionContent = self.question
//        CoreDataService.saveContext()
//        self.questionEntity.append(questionEntity)
//
//        //OptionEntity
//
//        for i in 0..<options.count
//        {
//            let optionEntity = OptionEntity(context: CoreDataService.context)
//            optionEntity.optionID = questionID + "_" + i.description
//            optionEntity.optionContent = options[i]
//            optionEntity.isSelected = false
//            if(i == correctKeyIndex)
//            {
//                optionEntity.isCorrectedKey = true
//            }
//            else
//            {
//                optionEntity.isCorrectedKey = false
//            }
//            optionEntity.outQuestionID = questionID
//            CoreDataService.saveContext()
//            self.optionEntity.append(optionEntity)
//        }
    }
}
