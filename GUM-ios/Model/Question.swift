//
//  SurveyQueestions.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 3/17/22.
//

import Foundation
class Question{
    let questionImage: String
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let response: String
    
    init(image: String, questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, Response: String){
        questionImage = image
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        response = Response
    }
}
