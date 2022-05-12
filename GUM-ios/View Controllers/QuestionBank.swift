//
//  QuestionBank.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 4/15/22.
//

import Foundation

class QuestionBank{
    var list = [Question]()
    
    init(){
        list.append(Question(questionText: "I used the Get Up and Move app ____ days this past week.", choiceA: "0", choiceB: "1-2", choiceC: "2-5", choiceD: "6-7"))
        list.append(Question(questionText: "Each day I used the GUM app this week, I completed approximatelly ___ guided activity sessions out of the possible six sessions", choiceA: "1-2", choiceB: "2-4", choiceC: "5-6", choiceD: "All 6 plus some extra sessions"))
        list.append(Question(questionText: "I reviewed approximately ____ teaching videos(s) from the GUM program this week", choiceA: "1-2", choiceB: "3-4", choiceC: "5-6", choiceD: "More than six"))
        list.append(Question(questionText: "I find that I have ____ since I started using the GUM mobile app.", choiceA: "Less engergy", choiceB: "About the same amount of energy", choiceC: "More energy", choiceD: ""))
        list.append(Question(questionText: "I find that I have ___ since I started using the GUM mobile app.", choiceA: "Less pain", choiceB: "About the same amount of pain", choiceC: "More pain", choiceD: ""))
        list.append(Question(questionText: "I find that I use ___ since I started using the GUM mobile app.", choiceA: "Fewer medications", choiceB: "About the same medications", choiceC: "More medicatios", choiceD: ""))
        list.append(Question(questionText: "I find that I have ___ since I started using the GUM mobile app.", choiceA: "Less mobility", choiceB: "About the same amount of mobiliy", choiceC: "More mobility", choiceD: ""))
        list.append(Question(questionText: "I find that my general wellbeing has ____ since I started using the GUM mobile app.", choiceA: "Decreased", choiceB: "Remained about the same", choiceC: "Increased", choiceD: ""))
        list.append(Question(questionText: "I find that I sit ___ throughout the whole day I started using the GUM app.", choiceA: "Less", choiceB: "About the same", choiceC: "More", choiceD: ""))
        list.append(Question(questionText: "I find that I sit ___ time without taking at least a 5 minute break to move around since I started using the GUM app.", choiceA: "Less", choiceB: "About the same", choiceC: "More", choiceD: ""))
        list.append(Question(questionText: "I used the Get Up and Move app ____ days this past week.", choiceA: "0", choiceB: "1-2", choiceC: "2-5", choiceD: "6-7"))
        list.append(Question(questionText: "How would you rate your engergy level when you wake up in the morning?", choiceA: "Low", choiceB: "Moderate", choiceC: "High", choiceD: ""))
        list.append(Question(questionText: "How would you rate your energy level throughout the day?", choiceA: "Low", choiceB: "Moderate", choiceC: "High", choiceD: ""))
        list.append(Question(questionText: "How would you rate your energy level when you go to bed in the evening", choiceA: "Low", choiceB: "Moderate", choiceC: "High", choiceD: ""))
        list.append(Question(questionText: "The level of intensity I chose when I started the GUM program: ", choiceA: "It still just right", choiceB: "I increased it", choiceC: "It was a little much I need to back off for a bit", choiceD: ""))
        
        
    }
}
