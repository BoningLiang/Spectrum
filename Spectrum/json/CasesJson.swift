//
//  CasesJson.swift
//  Spectrum
//
//  Created by Boning Liang on 2/12/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

struct OptionJson{
    let option: String
    let isCorrect: Bool
    let isSelect: Bool
    
//    init(json:[String:Any]) throws{
//        if json["option"] != nil {
//            self.option = json["option"] as! String
//        } else {
//            
//        }
//        if json["isCorrect"] != nil {
//            self.isCorrect = json["isCorrect"] as! Bool
//        } else {
//
//        }
//        if json["isSelect"] != nil {
//            self.isSelect = json["isSelect"] as! Bool
//        } else {
//
//        }
//    }
}

struct QuestionJson {
    let question: String
    let options: [OptionJson]
    
//    init?(json:[String:Any]) throws{
//        if json["question"] != nil {
//            self.question = json["question"] as! String
//        } else {
//
//        }
//
//    }
    
}

struct CaseJson {
    let caseID: Int
    let caseType: String
    let caseTitle: String
    let caseVideo: String
    let caseCoverImage: String
    let question: [QuestionJson]
    
//    init?(json:[String:Any]) throws{
//
//        guard let caseID = json["caseID"] as? Int else{
//            return nil
//        }
//
//
//
//        if json["caseID"] != nil {
//            self.caseID = json["caseID"] as! Int
//        }else{
//            self.caseID = -1
//        }
//        if json["caseType"] != nil {
//            self.caseType = json["caseType"] as! String
//        } else {
//
//        }
//        if json["caseTitle"] != nil {
//            self.caseTitle = json["caseTitle"] as! String
//        } else {
//
//        }
//        if json["caseVideo"] != nil {
//            self.caseVideo = json["caseVideo"] as! String
//        } else {
//
//        }
//        if json["caseCoverImage"] != nil {
//            self.caseCoverImage = json["caseCoverImage"] as! String
//        } else {
//
//        }
//
//
//
//    }
}
