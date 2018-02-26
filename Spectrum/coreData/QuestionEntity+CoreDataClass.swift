//
//  QuestionEntity+CoreDataClass.swift
//  Spectrum
//
//  Created by Boning Liang on 2/25/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


public class QuestionEntity<XEntity>: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }
    
    @NSManaged public var explanation: String?
    @NSManaged public var outCaseID: String?
    @NSManaged public var questionContent: String?
    @NSManaged public var questionID: String?
}
