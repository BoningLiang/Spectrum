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
    
    class func insertData(entity: NSManagedObject) -> Bool {
        let context = CoreDataService.context

        do {
            try context.save()
            return true
        } catch {
            return false
        }
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
    
    class func selectAllFromCaseEntity() -> [CaseEntity]
    {
        let context = CoreDataService.context
        var data: [CaseEntity]? = nil
        do {
            data = try context.fetch(CaseEntity.fetchRequest())
            return data!
        } catch {
            return data!
        }
    }
    
    
    class func selectData(entity: NSManagedObject, keys: [NSObject]) -> [NSObject]
    {
        let context = CoreDataService.context
        var data: [AnyObject]? = nil
        do {
            data = try context.fetch(NSManagedObject.fetchRequest())
            return data! as! [NSObject]
        } catch {
            return data! as! [NSObject]
        }
    }
}
