 //
//  SurveyViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/23/22.
//

import UIKit
import Firebase

class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
 
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    //Outlet for Buttons
    @IBOutlet weak var submitPickerBtn: UIButton!
    
    @IBOutlet weak var levelPicker: UIPickerView!
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var selectedAnswer: Int = 0
    let questionsSize = QuestionBank().list.count - 1
    var score: Int = 0
    let levels = ["Select Level", "1", "2", "3", "4", "5", "6", "7"]
    
    // Activate Firebase
    var email: String = ""
    var mylevel: String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        levelPicker.dataSource = self
        levelPicker.delegate = self
    }
    
    @IBAction func levelBtn(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData(["FitnessLvl": self.mylevel])
                self.performSegue(withIdentifier: "pickerView2", sender: document)
                print("hello")
            }
        }
    }
    
    func updateUI(){
        
    }
    
    func restartQuiz(){
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levels.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(levels[row])
        mylevel = levels[row]
        //let ref = Database.database().reference()
        //ref.child("Users/").
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "pickerView2"){
            let destinationVC = segue.destination as! PickerView
            destinationVC.email = email
        }
    }
}
