//
//  LoginSessionEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 6/22/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension LoginSessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginSessionEntity> {
        return NSFetchRequest<LoginSessionEntity>(entityName: "LoginSessionEntity")
    }

    @NSManaged public var userID: String?
    @NSManaged public var lastLoginTime: String?
    @NSManaged public var isLogin: Bool

}
