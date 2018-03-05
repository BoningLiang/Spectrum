//
//  serverController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/25/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

let baseURL = "http://auburn.edu/~bzl0048/spectrum/cases/"

class ServerController: NSObject{
    
    class func requestData(withRequest request:String, completion: @escaping ([myCase]?) -> ())
    {
        let url = baseURL + request
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var AllCases: [myCase] = []
            if let data = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    {
                        if let jsonCases = json["cases"]! as? [[String:Any]]
                        {
                            for jsonCase in jsonCases
                            {
                                var resultQuestions:[Question] = []
                                var resultTeachersNotes:[TeachersNote] = []
                                let caseID = jsonCase["caseID"] as? String
                                let caseName = jsonCase["caseName"] as? String
                                let caseDescription = jsonCase["caseDescription"] as? String
                                let caseVideoName = jsonCase["caseVideoName"] as? String
                                let caseType = jsonCase["caseType"] as? String
                                let caseCoverPic = jsonCase["caseCoverPic"] as? String
                                let caseVideoScreenshot = jsonCase["caseVideoScreenshot"] as? String
                                if let teachersNotes = jsonCase["teachersNotes"] as? [[String: Any]]
                                {
                                    for teachersNote in teachersNotes
                                    {
                                        
                                        let noteID = teachersNote["noteID"] as? String
                                        let noteVideo = teachersNote["noteVideo"] as? String
                                        let noteCover = teachersNote["noteCover"] as? String
                                        let resultTeachersNote = TeachersNote(
                                            noteID: noteID!,
                                            noteVideo: noteVideo!,
                                            noteCover: noteCover!,
                                            outCaseID: caseID!)
                                        resultTeachersNotes.append(resultTeachersNote)
                                    }
                                }
                                if let questions = jsonCase["questions"] as? [[String:Any]]
                                {
                                    for question in questions
                                    {
                                        let questionID = question["questionID"] as? String
                                        let questionContent = question["questionContent"] as? String
                                        let explanation = question["explanation"] as? String
                                        var resultJsonOptions:[Option] = []
                                        if let options = question["options"] as? [[String:Any]]
                                        {
                                            for jsonOption in options
                                            {
                                                let optionID = jsonOption["optionID"] as? String
                                                let optionContent = jsonOption["option"] as? String
                                                let isCorrect = jsonOption["isCorrect"] as? Bool
                                                let isSelect = jsonOption["isSelect"] as? Bool
                                                let resultJsonOption = Option(
                                                    optionID: optionID!,
                                                    optionContent: optionContent!,
                                                    isSelect: isSelect!,
                                                    isCorrect: isCorrect!,
                                                    outQuestionID: questionID!)
                                                resultJsonOptions.append(resultJsonOption)
                                            }
                                        }
                                        let resultQuestion = Question(
                                            questionID: questionID!,
                                            question: questionContent!,
                                            options: resultJsonOptions,
                                            explanation: explanation,
                                            expanded: false,
                                            outCaseID: caseID!)
                                        resultQuestions.append(resultQuestion)
                                    }
                                }
                                let resultCase = myCase(
                                    caseID: caseID!,
                                    caseName: caseName!,
                                    caseDescription: caseDescription!,
                                    caseVideoName: caseVideoName!,
                                    caseType: caseType!,
                                    caseCoverPic: caseCoverPic!,
                                    caseVideoScreenshot: caseVideoScreenshot!,
                                    teachersNote: resultTeachersNotes,
                                    questions: resultQuestions)
                                AllCases.append(resultCase)
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
                completion(AllCases)
            }
        }
        task.resume()
    }
}
