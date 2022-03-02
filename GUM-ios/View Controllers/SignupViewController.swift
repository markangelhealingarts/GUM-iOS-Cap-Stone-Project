//
//  SignupViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/23/22.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextView.becomeFirstResponder()
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        let email = emailTextView.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextView.text?.trimmingCharacters(in: .whitespaces)

        // checks if email / password is valid then adds user
        if(email != "" && isValidEmail(emailID: email!) && password != "") {
            
            let docRef = db.collection("Users").document(email!)
            
            print(docRef)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    print("email exists already!!!")
                } else {
                    
                    // add email and password
                    self.db.collection("Users").document(self.emailTextView.text!).setData([
                        "Password": password!,
                        "Points": 0,
                        "Score": 0,
                        "FitnessLvl": " ",
                        "AvatarUrl": " ",
                        "UnlockedAvatars": " "
                    ]) { (err) in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.performSegue(withIdentifier: "showSurvey", sender: nil)
                        }
                    }
                }
            }
            
        } else {
            print("didnt work adding")
        }
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}
