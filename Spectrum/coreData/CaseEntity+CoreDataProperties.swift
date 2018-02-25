//
//  CaseEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 2/25/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension CaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaseEntity> {
        return NSFetchRequest<CaseEntity>(entityName: "CaseEntity")
    }

    @NSManaged public var caseCoverPic: String?
    @NSManaged public var caseDescription: String?
    @NSManaged public var caseID: String
    @NSManaged public var caseName: String
    @NSManaged public var caseSection: String?
    @NSManaged public var caseType: String?
    @NSManaged public var caseVideoName: String?
    @NSManaged public var caseVideoScreenshot: String?

}
