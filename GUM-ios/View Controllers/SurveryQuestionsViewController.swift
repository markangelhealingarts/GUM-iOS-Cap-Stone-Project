

import UIKit
//import youtube_ios_player_helper_swift
import Firebase
class SurveryQuestionsViewController: UIViewController{
    let db = Firestore.firestore()
    var email: String = ""
    let allQuestion = QuestionBank()
    var questionNumber: Int = 0
    var selectedAnswer: Int = 0
    let questionSize = QuestionBank().list.count - 1
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestion()

    }

    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == 1{
            print("option a")
        } else if sender.tag == 2{
            print("option b")
        } else if sender.tag == 3{
            print("option c")
        } else {
          print("option d")
        }
        if(questionNumber == questionSize){
            let docRef = db.collection("Users").document(email)
            docRef.getDocument{ (document,error) in
                if let document = document, document.exists {
                    self.performSegue(withIdentifier: "homePage", sender: document)
                }
                
            }
        }
        updateQuestion()
    
    }
    func updateQuestion(){
        questionLabel.text = allQuestion.list[questionNumber].question
        optionA.setTitle(allQuestion.list[questionNumber].optionA, for: UIControl.State.normal)
        optionB.setTitle(allQuestion.list[questionNumber].optionB, for: UIControl.State.normal)
        optionC.setTitle(allQuestion.list[questionNumber].optionC, for: UIControl.State.normal)
        optionD.setTitle(allQuestion.list[questionNumber].optionD, for: UIControl.State.normal)
        questionNumber += 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "homePage"){
            let destinationVC = (segue.destination as! UINavigationController).topViewController as! MainPageViewController
            destinationVC.email = email
        }
    }
    }
    

