//
//  TeachersNoteEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 2/25/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension TeachersNoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeachersNoteEntity> {
        return NSFetchRequest<TeachersNoteEntity>(entityName: "TeachersNoteEntity")
    }

    @NSManaged public var noteCover: String?
    @NSManaged public var noteID: String?
    @NSManaged public var noteVideo: String?
    @NSManaged public var outCaseID: String?

}
