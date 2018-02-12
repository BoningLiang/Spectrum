//
//  myCase.swift
//  Spectrum
//
//  Created by Boning Liang on 2/8/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation
import CoreData

class myCase {
    var caseID: String!
    var caseVideoName: String!
    var caseSection: String!
    var caseEntity = [CaseEntity]()
    
    init(caseID: String, caseVideoName: String, caseSection: String) {
        self.caseID = caseID
        self.caseVideoName = caseVideoName
        self.caseSection = caseSection
//        print(checkIfExistInCoreData(caseID: self.caseID))
    }
    
//    func checkIfExistInCoreData(caseID: String) -> Bool
//    {
//        let fetchRequest: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
//        do{
//            let caseEntity = try CoreDataService.context.fetch(fetchRequest)
//            self.caseEntity = caseEntity
//        }catch{
//            print("Fetch request fails")
//        }
//        for i in 0..<caseEntity.count
//        {
//            if(caseEntity[i].caseID == caseID)
//            {
//                return true
//            }
//        }
//        return false
//    }
}
