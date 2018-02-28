//
//  OptionEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 2/28/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension OptionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OptionEntity> {
        return NSFetchRequest<OptionEntity>(entityName: "OptionEntity")
    }

    @NSManaged public var isCorrect: Bool
    @NSManaged public var isSelected: Bool
    @NSManaged public var optionContent: String?
    @NSManaged public var optionID: String?
    @NSManaged public var outQuestionID: String?

}
