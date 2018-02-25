//
//  Section.swift
//  Spectrum
//
//  Created by Boning Liang on 2/5/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation
import CoreData

struct Option {
    var optionID: String!
    var optionContent: String!
    var isSelect: Bool!
    var isCorrect: Bool!
    
    init(optionID: String, optionContent: String, isSelect:Bool, isCorrect: Bool) {
        self.optionID = optionID
        self.optionContent = optionContent
        self.isSelect = isSelect
        self.isCorrect = isCorrect
    }
    
    func insertDataToCoreData(outQuestionID:String)
    {
        let newOptionEntity:OptionEntity = OptionEntity(context: CoreDataService.context)
        
        newOptionEntity.optionID = self.optionID
        newOptionEntity.optionContent = self.optionContent
        newOptionEntity.isSelected = self.isSelect
        newOptionEntity.isCorrect = self.isCorrect
        newOptionEntity.outQuestionID = outQuestionID
        
        if(CoreDataController.insertData(entity: newOptionEntity))
        {
            print("Successfully insert option")
        }
    }
}

struct Question {
    var questionID:String!
    var question:String!
    var options:[Option]!
    var explanation:String!
    var expanded: Bool!
//    var outCaseID: String!
    var questionEntity = [QuestionEntity]()
    var optionEntity = [OptionEntity]()
    
    
    init(questionID: String, question: String, options: [Option], explanation:String!, expanded: Bool) {
        self.questionID = questionID
        self.question = question
        self.options = options
        self.explanation = explanation
        self.expanded = expanded
        
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
    
    func insertDataToCoreData(outCaseID:String)
    {
        let newQuestionEntity:QuestionEntity = QuestionEntity(context: CoreDataService.context)
        
        newQuestionEntity.questionID = self.questionID
        newQuestionEntity.questionContent = self.question
        newQuestionEntity.explanation = self.explanation
        newQuestionEntity.outCaseID = outCaseID
        
        if(CoreDataController.insertData(entity: newQuestionEntity))
        {
            print("Successfully insert question")
        }
        
        for i in 0..<self.options.count
        {
            self.options[i].insertDataToCoreData(outQuestionID: self.questionID)
        }
    }
}
