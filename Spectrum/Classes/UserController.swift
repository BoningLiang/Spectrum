//
//  UserController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/16/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

struct LoginResult: Decodable{
    var result: Int
}

class UserController {
    var userID: String?
    var username: String?;
    var userPassword: String?;
    var timestamp: String?;
    var isLogin: Bool;
    
    init() {
        self.isLogin = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func login(username: String, userPassword: String){
        
        
    }
    
    func loginCheck() -> Bool
    {
        return true;
    }
    
}
