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
    var outQuestionID: String!
    
    init(optionID: String, optionContent: String, isSelect:Bool, isCorrect: Bool, outQuestionID: String) {
        self.optionID = optionID
        self.optionContent = optionContent
        self.isSelect = isSelect
        self.isCorrect = isCorrect
        self.outQuestionID = outQuestionID
//        self.insertDataToCoreData()
    }
    
//    func insertDataToCoreData()
//    {
//        if CoreDataController.insertDataToOptionEntity(
//            optionID: self.optionID,
//            optionContent: self.optionContent,
//            isCorrect: self.isCorrect,
//            isSelected: self.isSelect,
//            outQuestionID: self.outQuestionID) {
//            print("Successfully insert option with ID: " + self.optionID)
//        }
//        else
//        {
//            print("Fail insert option with ID: " + self.optionID)
//        }
//    }
}

struct Question {
    var questionID:String!
    var question:String!
    var options:[Option]!
    var explanation:String!
    var expanded: Bool!
    var outCaseID: String!
    var questionEntity = [QuestionEntity]()
    var optionEntity = [OptionEntity]()
    
    init(questionID: String, question: String, options: [Option], explanation:String!, expanded: Bool, outCaseID: String) {
        self.questionID = questionID
        self.question = question
        self.options = options
        self.explanation = explanation
        self.expanded = expanded
        self.outCaseID = outCaseID
//        self.insertDataToCoreData(outCaseID: outCaseID)
    }
    
//    func insertDataToCoreData(outCaseID:String)
//    {
//        if CoreDataController.insertDataToQuestionEntity(
//            questionID: self.questionID,
//            questionContent: self.question,
//            explanation: self.explanation,
//            outCaseID: outCaseID) {
//            print("Successfully insert question with ID: " + self.questionID)
//        }
//        else
//        {
//            print("Fail insert question with ID: " + self.questionID)
//        }
//    }
}
