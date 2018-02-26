//
//  TeachersNoteEntity+CoreDataClass.swift
//  Spectrum
//
//  Created by Boning Liang on 2/24/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


public class TeachersNoteEntity<XEntity>: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeachersNoteEntity> {
        return NSFetchRequest<TeachersNoteEntity>(entityName: "TeachersNoteEntity")
    }
    
    @NSManaged public var noteCover: String?
    @NSManaged public var noteID: String?
    @NSManaged public var noteVideo: String?
    @NSManaged public var outCaseID: String?
}
