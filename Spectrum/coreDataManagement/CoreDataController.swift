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
//    class func insertData(entity: NSManagedObject, data: [String: String]) -> Bool {
//        for (key, value) in data {
//            entity.setValue(value, forKey: key)
//        }
//        let context = entity.managedObjectContext
//
//        do {
//            try context?.save()
//            return true
//        } catch {
//            return false
//        }
//    }
    
    class func insertDataToCaseEntity(caseID: String, caseSection: String, caseVideoName: String, caseName: String, caseDescription: String, caseCoverPic: String, caseVideoScreenshot: String, caseType: String) -> Bool {
        
        print("found "+CoreDataController.selectCaseWithID(id: "1").count.description+"case(s)")
        let forConstrainCount = selectCaseWithID(id: caseID).count
        if(forConstrainCount==0)
        {
            let context = CoreDataService.context
            let newCaseEntity = NSEntityDescription.insertNewObject(forEntityName: "CaseEntity", into: context) as! CaseEntity
            
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
    
    class func insertData() -> Bool
    {
        let context = CoreDataService.context
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func insertDataToQuestionEntity()
    {
        //todo
    }
    
    class func insertDataToOptionEntity()
    {
        //todo
    }
    
//    class func selectAllData(data: NSManagedObject) -> [NSObject]
//    {
//        let context = CoreDataService.context
////        var data: [AnyObject]? = nil
//        do {
//            data = try context.fetch(NSManagedObject.fetchRequest())
//            return data! as! [NSObject]
//        } catch {
//            return data! as! [NSObject]
//        }
//    }
    
    class func selectAllCaseEntity() -> [CaseEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = CaseEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [CaseEntity]()
        do {
            result = try context.fetch(fetchRequest) as! [CaseEntity]
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
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = QuestionEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [QuestionEntity]()
        do {
            result = try context.fetch(fetchRequest) as! [QuestionEntity]
            return result
        } catch {
            print("Fetch all QuestionEntity fail!")
            return result
        }
    }
    
    class func selectAllTeachersNoteEntity() -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = TeachersNoteEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [TeachersNoteEntity]()
        do {
            result = try context.fetch(fetchRequest) as! [TeachersNoteEntity]
            return result
        } catch {
            print("Fetch all TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectAllOptionEntity() -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = OptionEntity.fetchRequest()
        let context = CoreDataService.context
        var result = [OptionEntity]()
        do {
            result = try context.fetch(fetchRequest) as! [OptionEntity]
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
            result = try context.fetch(myFetchRequest) as! [CaseEntity]
            print("Fetch CaseEntity success")
            return result
        } catch {
            print("Fetch CaseEntity fail!")
            return result
        }
    }
    
    class func selectQuestionWithID(id: String) -> [QuestionEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = QuestionEntity.fetchRequest()
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
            result = try context.fetch(fetchRequest) as! [QuestionEntity]
            return result
        } catch {
            print("Fetch QuestionEntity fail!")
            return result
        }
    }
    
    class func selectQuestionWithforeignCaseID(foreignCaseID: String) -> [QuestionEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = QuestionEntity.fetchRequest()
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
            result = try context.fetch(fetchRequest) as! [QuestionEntity]
            return result
        } catch {
            print("Fetch QuestionEntity fail!")
            return result
        }
    }
    
    class func selectTeachersNoteWithID(id: String) -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = TeachersNoteEntity.fetchRequest()
        var result = [TeachersNoteEntity]()
        let context = CoreDataService.context
        var subPredicates = [NSPredicate]()
        let predicate = NSPredicate(format: "noteID == %@", id)
        subPredicates.append(predicate)
        if subPredicates.count>0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            result = try context.fetch(fetchRequest) as! [TeachersNoteEntity]
            return result
        } catch {
            print("Fetch TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectTeachersNoteWithForeignCaseID(foreignCaseID: String) -> [TeachersNoteEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = TeachersNoteEntity.fetchRequest()
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
            result = try context.fetch(fetchRequest) as! [TeachersNoteEntity]
            return result
        } catch {
            print("Fetch TeachersNoteEntity fail!")
            return result
        }
    }
    
    class func selectOptionWithID(id: String) -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = OptionEntity.fetchRequest()
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
            result = try context.fetch(fetchRequest) as! [OptionEntity]
            return result
        } catch {
            print("Fetch OptionEntity fail!")
            return result
        }
    }
    
    class func selectOptionWithForeignQuestionID(foreignQuestionID: String) -> [OptionEntity]
    {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = OptionEntity.fetchRequest()
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
            result = try context.fetch(fetchRequest) as! [OptionEntity]
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
    
    class func updateOptionEntityWithID() -> Bool
    {
        //todo
        return false
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
}
