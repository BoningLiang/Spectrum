//
//  CoreDataController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/24/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject {
    class func insertData(entity: NSManagedObject, data: [String: String]) -> Bool {
        for (key, value) in data {
            entity.setValue(value, forKey: key)
        }
        let context = entity.managedObjectContext

        do {
            try context?.save()
            return true
        } catch {
            return false
        }
    }
    
    class func insertDataToCaseEntity(caseID: String, caseSection: String, caseVideoName: String, caseName: String, caseDescription: String, caseCoverPic: String, caseVideoScreenshot: String, caseType: String) -> Bool {
        
        print("found "+CoreDataController.selectCaseWithID(id: "1").count.description+"case(s)")
        let forConstrainCount = CoreDataController.selectCaseWithID(id: caseID).count
        if(forConstrainCount==0)
        {
            let context = CoreDataService.context
            let newCaseEntity = NSEntityDescription.insertNewObject(forEntityName: "CaseEntity", into: context) as! CaseEntity<Any>
            
            newCaseEntity.setValue(caseID, forKey: "caseID")
            newCaseEntity.setValue(caseDescription, forKey: "caseDescription")
            newCaseEntity.setValue(caseCoverPic, forKey: "caseCoverPic")
            newCaseEntity.setValue(caseName, forKey: "caseName")
            newCaseEntity.setValue(caseType, forKey: "caseType")
            newCaseEntity.setValue(caseType, forKey: "caseSection")
            newCaseEntity.setValue(caseVideoName, forKey: "caseVideoName")
            newCaseEntity.setValue(caseVideoScreenshot, forKey: "caseVideoScreenshot")
            
            do {
                try context.save()
                print("insert to CaseEntity success!")
                return true
            } catch {
                print("insert to CaseEntity fail!")
                return false
            }
        }
        else
        {
            if(forConstrainCount>1)
            {
                print("Constrain failure!")
            }
            if(forConstrainCount==1)
            {
                print("Constrain success!")
            }
            return false
        }
    }
    
    class func insertDataToTeachersNoteEntity(noteID:String, noteVideo:String, noteCover: String, outCaseID: String) -> Bool
    {
        print("found "+CoreDataController.selectTeachersNoteWithID(id: noteID).count.description+"note(s)")
        let forConstrainCount = CoreDataController.selectTeachersNoteWithID(id: noteID).count
        if(forConstrainCount==0)
        {
            let context = CoreDataService.context
            let newTeachersNoteEntity = NSEntityDescription.insertNewObject(forEntityName: "TeachersNoteEntity", into: context) as! TeachersNoteEntity
            
            newTeachersNoteEntity.setValue(noteID, forKey: "noteID")
            newTeachersNoteEntity.setValue(noteVideo, forKey: "noteVideo")
            newTeachersNoteEntity.setValue(noteCover, forKey: "noteCover")
            newTeachersNoteEntity.setValue(outCaseID, forKey: "outCaseID")
            
            do {
                try context.save()
                print("insert to TeachersNoteEntity success!")
                return true
            } catch {
                print("insert to TeachersNoteEntity fail!")
                return false
            }
        }
        else
        {
            if(forConstrainCount>1)
            {
                print("Constrain failure!")
            }
            if(forConstrainCount==1)
            {
                print("Constrain success!")
            }
            return false
        }
    }
    
    class func insertDataToQuestionEntity(questionID: String, questionContent: String, explanation: String, outCaseID: String) -> Bool
    {
        print("found "+CoreDataController.selectQuestionWithID(id: questionID).count.description+"case(s)")
        let forConstrainCount = CoreDataController.selectQuestionWithID(id: questionID).count
        if(forConstrainCount==0)
        {
            let context = CoreDataService.context
            let newQuestionEntity = NSEntityDescription.insertNewObject(forEntityName: "QuestionEntity", into: context) as! QuestionEntity

            newQuestionEntity.setValue(questionID, forKey: "questionID")
            newQuestionEntity.setValue(questionContent, forKey: "questionContent")
            newQuestionEntity.setValue(explanation, forKey: "explanation")
            newQuestionEntity.setValue(outCaseID, forKey: "outCaseID")

            do {
                try context.save()
                print("insert to QuestionEntity success!")
                return true
            } catch {
                print("insert to QuestionEntity fail!")
                return false
            }
        }
        else
        {
            if(forConstrainCount>1)
            {
                print("Constrain failure!")
            }
            if(forConstrainCount==1)
            {
                print("Constrain success!")
            }
            return false
        }
    }
    
    class func insertDataToOptionEntity(optionID: String, optionContent: String, isCorrect: Bool, isSelected: Bool, outQuestionID: String) -> Bool
    {
        print("found "+CoreDataController.selectOptionWithID(id: optionID).count.description+" options(s)")
        let forConstrainCount = selectOptionWithID(id: optionID).count
        if(forConstrainCount==0)
        {
            let context = CoreDataService.context
            let newOptionEntity = NSEntityDescription.insertNewObject(forEntityName: "OptionEntity", into: context) as! OptionEntity

            newOptionEntity.setValue(optionID, forKey: "optionID")
            newOptionEntity.setValue(optionContent, forKey: "optionContent")
            newOptionEntity.setValue(isCorrect, forKey: "isCorrect")
            newOptionEntity.setValue(isSelected, forKey: "isSelected")
            newOptionEntity.setValue(outQuestionID, forKey: "outQuestionID")

            do {
                try context.save()
                print("insert to OptionEntity success!")
                return true
            } catch {
                print("insert to OptionEntity fail!")
                return false
            }
        }
        else
        {
            if(forConstrainCount>1)
            {
                print("Constrain failure!")
            }
            if(forConstrainCount==1)
            {
                print("Constrain success!")
            }
            return false
        }
    }
    
    class func insertData() -> Bool
    {
        let context = CoreDataService.context
        do {
            try context.save()
            print("Insert Data Successful")
            return true
        } catch {
            print("Insert Data Fail")
            return false
        }
    }
    
    class func selectAllXEntity() -> [XEntity]
    {
        let fetchRequest: NSFetchRequest<XEntity> = XEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [XEntity]()
        
        return result
    }
    
    class func selectAllCaseEntity() -> [CaseEntity]
    {
        let fetchRequest:NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [CaseEntity]()
        do {
            print("selectAllCaseEntity: fetching...")
            result = try context.fetch(fetchRequest)
            print("Fetch all CaseEntity success! With: " + result.count.description + " result(s)!")
            
            for resultCaseEntity in result
            {
                print(resultCaseEntity.caseName)
                print(resultCaseEntity.caseID)
            }
            
            return result
        } catch {
            print("Fetch all CaseEntity fail!")
            return result
        }
    }
    
    class func selectAllQuestionEntity() -> [QuestionEntity]
    {
        let fetchRequest:NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [QuestionEntity]()
        do {
            print("selectAllQuestionEntity: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch all QuestionEntity fail!")
            return result
        }
    }
    
    class func selectAllTeachersNoteEntity() -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<TeachersNoteEntity> = TeachersNoteEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [TeachersNoteEntity]()
        do {
            print("selectAllTeachersNoteEntity: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch all TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectAllOptionEntity() -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<OptionEntity> = OptionEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [OptionEntity]()
        do {
            print("selectAllOptionEntity: fetching...")
            result = try context.fetch(fetchRequest) 
            return result
        } catch {
            print("Fetch all OptionEntity fail!")
            return result
        }
    }
    
    class func selectCaseWithID(id: String) -> [CaseEntity]
    {
        let myFetchRequest:NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
        var result = [CaseEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "caseID == %@", id)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            myFetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectCaseWithID: fetching...")
            result = try context.fetch(myFetchRequest)
            print("Fetch CaseEntity success")
            return result
        } catch {
            print("Fetch CaseEntity fail!")
            return result
        }
    }
    
    class func selectQuestionWithID(id: String) -> [QuestionEntity]
    {
        let fetchRequest:NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        var result = [QuestionEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "questionID == %@", id)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectQuestionWithID: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch QuestionEntity fail!")
            return result
        }
    }
    
    class func selectQuestionWithforeignCaseID(foreignCaseID: String) -> [QuestionEntity]
    {
        let fetchRequest:NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        var result = [QuestionEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "outCaseID == %@", foreignCaseID)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectQuestionWithforeignCaseID: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch QuestionEntity fail!")
            return result
        }
    }
    
    class func selectTeachersNoteWithID(id: String) -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<TeachersNoteEntity> = TeachersNoteEntity.fetchRequest()
        var result = [TeachersNoteEntity]()
        let context = CoreDataService.context
        let predicate = NSPredicate(format: "noteID == %@", id)
        fetchRequest.predicate = predicate
        do {
            print("selectTeachersNoteWithID: fetching...")
//            print(fetchRequest)
            result = try context.fetch(fetchRequest)
            print("Fetch TeachersNoteEntity success!")
            return result
        } catch {
            print("Fetch TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectTeachersNoteWithForeignCaseID(foreignCaseID: String) -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<TeachersNoteEntity> = TeachersNoteEntity.fetchRequest()
        var result = [TeachersNoteEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "outCaseID == %@", foreignCaseID)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectTeachersNoteWithForeignCaseID: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectOptionWithID(id: String) -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<OptionEntity> = OptionEntity.fetchRequest()
        var result = [OptionEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "optionID == %@", id)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectOptionWithID: fetching...")
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Fetch OptionEntity fail!")
            return result
        }
    }
    
    class func selectOptionWithForeignQuestionID(foreignQuestionID: String) -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<OptionEntity> = OptionEntity.fetchRequest()
        var result = [OptionEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "outQuestionID == %@", foreignQuestionID)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            print("selectOptionWithForeignQuestionID: fetching...")
            result = try context.fetch(fetchRequest) 
            return result
        } catch {
            print("Fetch OptionEntity fail!")
            return result
        }
    }
    
    class func updateCaseEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func updateQuestionEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func updateOptionEntityWithID(optionID: String, isSelect: Bool) -> Bool
    {
        //todo
        let fetchRequest:NSFetchRequest<OptionEntity> = OptionEntity.fetchRequest()
        var result = [OptionEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "optionID == %@", optionID)
        subPredicates.append(predicate)
        if subPredicates.count>0
        {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do
        {
            print("updateOptionEntityWithID: fetching...")
            result = try context.fetch(fetchRequest) 
        }catch{
            print("Fetch OptionEntity fail!")
            return false
        }
        if result.count>0
        {
            let managedObject = result[0]
            managedObject.setValue(isSelect, forKey: "isSelected")
            do{
                try context.save()
                return true
            }catch{
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    class func updateTeachersNoteEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteCaseEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteQuestionEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteOptionEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteTeachersNoteEntityWithID() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteAllCaseEntity() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteAllOptionEntity() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteAllQuestionEntity() -> Bool
    {
        //todo
        return false
    }
    
    class func deleteAllTeachersNoteEntity() -> Bool
    {
        //todo
        return false
    }
    
    
    
    class func deleteData(entity: NSManagedObject) -> Bool
    {
        let context = CoreDataService.context
        context.delete(entity)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func getAllCasesFromCoreData() -> [myCase] {
        var resultCases: [myCase] = []
        let caseEntities = CoreDataController.selectAllCaseEntity()
        
        print("case count: "+caseEntities.count.description)
        for caseEntity in caseEntities
        {
            let teachersNoteEntities = CoreDataController.selectTeachersNoteWithForeignCaseID(foreignCaseID: caseEntity.caseID)
            var resultTeachersNotes:[TeachersNote] = []
            print("teachers notes count: "+teachersNoteEntities.count.description)
            for teachersNoteEntity in teachersNoteEntities
            {
                let resultTeachersNote:TeachersNote = TeachersNote(
                    noteID: teachersNoteEntity.noteID!,
                    noteVideo: teachersNoteEntity.noteVideo!,
                    noteCover: teachersNoteEntity.noteCover!,
                    outCaseID: caseEntity.caseID)
                resultTeachersNotes.append(resultTeachersNote)
            }
            
            let questionEntities = CoreDataController.selectQuestionWithforeignCaseID(foreignCaseID: caseEntity.caseID)
            var resultQuestions:[Question] = []
            print("question count: "+questionEntities.count.description)
            for questionEntity in questionEntities
            {
                let optionEntities = CoreDataController.selectOptionWithForeignQuestionID(foreignQuestionID: questionEntity.questionID!)
                var resultOptions:[Option] = []
                print("option count: "+optionEntities.count.description)
                for optionEntity in optionEntities
                {
                    
                    let resultOption = Option(
                        optionID: optionEntity.optionID!,
                        optionContent: optionEntity.optionContent!,
                        isSelect: optionEntity.isSelected,
                        isCorrect: optionEntity.isCorrect,
                        outQuestionID: questionEntity.questionID!)
                    resultOptions.append(resultOption)
                }
                
                let resultQuestion = Question(
                    questionID: questionEntity.questionID!,
                    question: questionEntity.questionContent!,
                    options: resultOptions,
                    explanation: questionEntity.explanation,
                    expanded: false,
                    outCaseID: caseEntity.caseID)
                resultQuestions.append(resultQuestion)
            }
            let resultCase:myCase = myCase(
                caseID: caseEntity.caseID,
                caseName: caseEntity.caseName,
                caseDescription: caseEntity.caseDescription!,
                caseVideoName: caseEntity.caseVideoName!,
                caseType: caseEntity.caseType!,
                caseCoverPic: caseEntity.caseCoverPic!,
                caseVideoScreenshot: caseEntity.caseVideoScreenshot!,
                teachersNote: resultTeachersNotes,
                questions: resultQuestions)
            resultCases.append(resultCase)
        }
        return resultCases
    }
}
