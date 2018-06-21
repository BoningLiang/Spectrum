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
    
    init(noteID: String, noteVideo: String, noteCover:String, outCaseID: String) {
        self.noteID = noteID
        self.noteCover = noteCover
        self.noteVideo = noteVideo
//        self.insertDataToCoreData(outCaseID: outCaseID)
    }
    
//    func insertDataToCoreData(outCaseID: String)
//    {
//        if CoreDataController.insertDataToTeachersNoteEntity(
//            noteID: self.noteID,
//            noteVideo: self.noteVideo,
//            noteCover: self.noteCover,
//            outCaseID: outCaseID) {
//            print("Successfully insert teachers note with ID: " + self.noteID)
//        }
//        else
//        {
//            print("Fail insert teachers note with ID: " + self.noteID)
//        }
//    }
    
}

class myCase {
    var caseID: String!
    var caseName: String!
    var caseDescription: String!
    var caseVideoName: String!
//    var caseChapter: String!
    var caseChapter: String!
    
    var caseCoverPic: String!
    var caseVideoScreenshot: String!
    var teachersNote: [TeachersNote]
    var questions: [Question]!

    
    init(caseID: String, caseName:String, caseDescription: String, caseVideoName: String, caseChapter: String, caseCoverPic: String,caseVideoScreenshot: String, teachersNote: [TeachersNote], questions: [Question]) {
        self.caseID = caseID
        self.caseName = caseName
        self.caseDescription = caseDescription
        self.caseVideoName = caseVideoName
        self.caseChapter = caseChapter
        self.caseCoverPic = caseCoverPic
        self.questions = questions
        self.teachersNote = teachersNote
        self.caseVideoScreenshot = caseVideoScreenshot
//        self.insertDataToCoreData()
    }
    
//    func insertDataToCoreData()
//    {
//        if(CoreDataController.insertDataToCaseEntity(caseID: self.caseID, caseSection: self.caseChapter, caseVideoName: self.caseVideoName, caseName: self.caseName, caseDescription: self.caseDescription, caseCoverPic: self.caseCoverPic, caseVideoScreenshot: self.caseVideoScreenshot, caseChapter: self.caseChapter))
//        {
//            print("Successfully insert case with ID: " + self.caseID)
//        }
//    }
}
