//
//  LoginUserEntity+CoreDataProperties.swift
//  Spectrum
//
//  Created by Boning Liang on 3/25/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//
//

import Foundation
import CoreData


extension LoginUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginUserEntity> {
        return NSFetchRequest<LoginUserEntity>(entityName: "LoginUserEntity")
    }

    @NSManaged public var userID: Int64
    @NSManaged public var userName: String?
    @NSManaged public var userPassword: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userAvatar: String?
    @NSManaged public var userIsLogin: Bool

}
