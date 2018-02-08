//
//  Section.swift
//  Spectrum
//
//  Created by Boning Liang on 2/5/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

struct Question {
    var question:String!
    var options:[String]!
    var expanded: Bool!
    
    init(question: String, options: [String], expanded: Bool) {
        self.question = question
        self.options = options
        self.expanded = expanded
    }
}
