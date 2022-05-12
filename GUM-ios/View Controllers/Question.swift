//
//  Questions.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 4/15/22.
//

import Foundation

class Question {
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    
    init(questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String){
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
    }
}
