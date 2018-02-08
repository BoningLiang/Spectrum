//
//  QuestionEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 2/8/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var questionContent: String?
    @NSManaged public var questionID: String?
    @NSManaged public var outCaseID: String?
}

// MARK: Generated accessors for toOption
extension QuestionEntity {

    @objc(addToOptionObject:)
    @NSManaged public func addToToOption(_ value: OptionEntity)

    @objc(removeToOptionObject:)
    @NSManaged public func removeFromToOption(_ value: OptionEntity)

    @objc(addToOption:)
    @NSManaged public func addToToOption(_ values: NSSet)

    @objc(removeToOption:)
    @NSManaged public func removeFromToOption(_ values: NSSet)

}
