//
//  QuestionBank.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 3/17/22.
//

import Foundation

class QuestionBank{
    var list = [Question]()
    
    init() {
        list.append(Question(image: "GUMapp", questionText: "I used the Get Up and Move app _____ days this past week.", choiceA: "0 days", choiceB: "1-2 days", choiceC: "3-5 days", choiceD: "6-7 days", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I reviewed approximately ______ teaching video(s) from the GUM program this week.", choiceA: "1-2", choiceB: "3-4", choiceC: "5-6", choiceD: "More than six", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I have _____ since I started using the GUM mobile app.", choiceA: "Less energy", choiceB: "About the same amount of energy", choiceC: "More energy", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I have ____ since I started using the GUM mobile app.", choiceA: "Less pain", choiceB: "About the same amount of pain", choiceC: "More pain", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I use ____ since I started using the GUM mobile app.", choiceA: "Fewer medications", choiceB: "About the same amount of medications", choiceC: "More medications", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I have ____ since I started using the GUM mobile app.", choiceA: "Less mobility", choiceB: "About the same amount of mobility", choiceC: "More mobility", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that my general wellbeing has _____ since I started using the GUM mobile app.", choiceA: "Decreased", choiceB: "Remained about the same", choiceC: "Increased", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I sit ____ throughout the whole day since I started using the GUM mobile app.", choiceA: "Less", choiceB: "About the same", choiceC: "More", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "I find that I sit ____ time without taking at least 5 minute break to move around since I started using the GUM mobile app.", choiceA: "Less", choiceB: "About the same", choiceC: "More", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "How would you rate your energy level when you wake up in the morning?", choiceA: "Low", choiceB: "Moderate", choiceC: "High", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "How would you rate your energy level when you go to bed in the evening?", choiceA: "Low", choiceB: "Moderate", choiceC: "High", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "The level of intensity I chose when I started the GUM program: ", choiceA: "It still just right", choiceB: "I increased it", choiceC: "It was a little much I need to back off for a bit", choiceD: "", Response: "Here"))
        list.append(Question(image: "GUMapp", questionText: "The GUM program is a good fit in my daily routine.", choiceA: "Very true", choiceB: "Mostly true", choiceC: "Partly true", choiceD: "Not very true", Response: "Here"))
    }
}
