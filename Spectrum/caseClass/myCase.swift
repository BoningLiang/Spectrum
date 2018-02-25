//
//  myCase.swift
//  Spectrum
//
//  Created by Boning Liang on 2/8/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation
import CoreData

struct TeachersNote {
    var noteID: String!
    var noteVideo: String!
    var noteCover: String!
    
    init(noteID: String, noteVideo: String, noteCover:String) {
        self.noteID = noteID
        self.noteCover = noteCover
        self.noteVideo = noteVideo
    }
    
    func insertDataToCoreData(outCaseID: String)
    {
        let context = CoreDataService.context
        let newTeachersNoteEntity = NSEntityDescription.insertNewObject(forEntityName: "TeachersNoteEntity", into: context) as! TeachersNoteEntity
        
        newTeachersNoteEntity.noteID = self.noteID
        newTeachersNoteEntity.noteVideo = self.noteVideo
        newTeachersNoteEntity.noteCover = self.noteCover
        newTeachersNoteEntity.outCaseID = outCaseID
        
        if(CoreDataController.insertData())
        {
            print("Successfully insert teachers note")
        }
    }
    
}

class myCase {
    var caseID: String!
    var caseName: String!
    var caseDescription: String!
    var caseVideoName: String!
    var caseType: String!
    var caseCoverPic: String!
    var caseVideoScreenshot: String!
    var teachersNote: [TeachersNote]
    var questions: [Question]!

    
    init(caseID: String, caseName:String, caseDescription: String, caseVideoName: String, caseType: String, caseCoverPic: String,caseVideoScreenshot: String, teachersNote: [TeachersNote], questions: [Question]) {
        self.caseID = caseID
        self.caseName = caseName
        self.caseDescription = caseDescription
        self.caseVideoName = caseVideoName
        self.caseType = caseType
        self.caseCoverPic = caseCoverPic
        self.questions = questions
        self.teachersNote = teachersNote
        self.caseVideoScreenshot = caseVideoScreenshot
    }
    
    func insertDataToCoreData()
    {
        CoreDataController.insertDataToCaseEntity(caseID: self.caseID, caseSection: self.caseType, caseVideoName: self.caseVideoName, caseName: self.caseName, caseDescription: self.caseDescription, caseCoverPic: self.caseCoverPic, caseVideoScreenshot: self.caseVideoScreenshot, caseType: self.caseType)
        

        for i in 0..<self.teachersNote.count
        {
            self.teachersNote[i].insertDataToCoreData(outCaseID: self.caseID)
        }
//
//        for i in 0..<self.questions.count
//        {
//            self.questions[i].insertDataToCoreData(outCaseID: self.caseID)
//        }
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
    
//    func checkIfExistInCoreData(caseID: String) -> Bool
//    {
//        let fetchRequest: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
//        do{
//            let caseEntity = try CoreDataService.context.fetch(fetchRequest)
//            self.caseEntity = caseEntity
//        }catch{
//            print("Fetch request fails")
//        }
//        for i in 0..<caseEntity.count
//        {
//            if(caseEntity[i].caseID == caseID)
//            {
//                return true
//            }
//        }
//        return false
//    }
}
