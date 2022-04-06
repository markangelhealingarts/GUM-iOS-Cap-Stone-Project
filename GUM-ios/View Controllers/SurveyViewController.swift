 //
//  SurveyViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/23/22.
//

import UIKit

class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var levelTextField: UITextField!
    //Outlet for Buttons
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    let levels = ["Select a Level", "1", "2", "3", "4", "5", "6", "7"]
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var selectedAnswer: Int = 0
    let questionsSize = QuestionBank().list.count - 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        levelPicker.dataSource = self
        levelPicker.delegate = self
        levelTextField.inputView = levelPicker
    }
    
    @IBAction func responsePressed(_ sender: UIButton) {
//        if sender.tag == 1{
//            print("option a")
//        }else if sender.tag == 2{
//            print("option b")
//        }else if sender.tag == 3{
//            print("option c")
//        }else{
//            print("option d")
//        }
        
//        if sender.tag == selectedAnswer{
//            print("correct")
//            score += 1
//        }
        if questionNumber == questionsSize{
           // performSegue(withIdentifier: "", sender: nil)
            print("hello")
        }else{
            updateQuestion()
        }
        
    }
    
    func updateQuestion(){
        print(questionNumber)
        questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControl.State.normal)
            //selectedAnswer = allQuestions.list[questionNumber].response
            questionNumber += 1
    
    }
    
    func updateUI(){
        
    }
    
    func restartQuiz(){
        
    }
    
}
extension SurveyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levels.count
    }
}
