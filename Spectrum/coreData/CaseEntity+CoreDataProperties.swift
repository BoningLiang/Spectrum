//
//  CaseEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 2/8/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension CaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaseEntity> {
        return NSFetchRequest<CaseEntity>(entityName: "CaseEntity")
    }

    @NSManaged public var caseID: String?
    @NSManaged public var caseVideoName: String?
    @NSManaged public var caseSection: String?

}
