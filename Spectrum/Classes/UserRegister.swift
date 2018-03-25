//
//  UserRegister.swift
//  Spectrum
//
//  Created by Boning Liang on 3/4/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

class UserRegister {
    var userDisplayName: String!
    var userPassword: String!
    var userEmail: String!

    init(userDisplayName: String, userPassword: String, userEmail: String) {
        self.userDisplayName = userDisplayName
        self.userPassword = userPassword
        self.userEmail = userEmail
    }
    
    class func checkPassword(userPassword: String) -> Bool
    {
        // at least one uppercase letter
        // at least one lowercase letter
        // at least one numeric digit
        // at least 10 characters long
        let passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{10,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return pred.evaluate(with: userPassword)
    }
    
    class func checkEmail(userEmail: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return pred.evaluate(with: userEmail)
    }
    
    class func checkCode(code: String) -> Bool
    {
        let codeRegex = "[1-9][0-9]{5}"
        let pred = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        return pred.evaluate(with: code)
    }
}
