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
    var emailinfo: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextView.becomeFirstResponder()
    }
    
<<<<<<< HEAD
    @IBAction func createAccount(_ sender: UIButton) {
        
        let email = emailTextView.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextView.text?.trimmingCharacters(in: .whitespaces)

        // checks if email / password is valid then adds user
=======
    @IBAction func createAccount(_ sender: Any) {
       // makeAccount()
        print("helo")
        let email = emailTextView.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextView.text?.trimmingCharacters(in: .whitespaces)
        print(email)
        print(password)
      // checks if email / password is valid then adds user
>>>>>>> origin/sophia
        if(email != "" && isValidEmail(emailID: email!) && password != "") {

            let docRef = db.collection("Users").document(email!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
<<<<<<< HEAD
                    
=======

>>>>>>> origin/sophia
                    let alert = UIAlertController(title: "Error", message: "Email already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                } else {
                    // add email and password
                    self.db.collection("Users").document(self.emailTextView.text!).setData([
                        "Password": password!,
                        "Points": 0,
                        "Score": 0,
                        "FitnessLvl": " ",
                        "AvatarUrl": "orange_avatar.png",
                        "UnlockedAvatars": ["orange_avatar.png"],
                        "Schedule": ["9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM", "3:00 PM", "4:00 PM"]
                    ]) { (err) in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
<<<<<<< HEAD
                            self.performSegue(withIdentifier: "showSurvey", sender: nil)
                        }
                    }
                }
            }
            
        } else {
            
            if(email == "" || password == ""){
                let alert = UIAlertController(title: "Error", message: "Email/Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "Not valid email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
=======
                            let doc = self.db.collection("Users").document(email!)
                            doc.getDocument {(document, error) in
                                if let document = document, document.exists {
                                    self.emailinfo = email!
                                    print(document)
                            self.performSegue(withIdentifier: "introVideo", sender: document)
                                }
                           }

                        
                        
                    
                }
            }

        } //else {
//
//            if(email == "" || password == ""){
//                let alert = UIAlertController(title: "Error", message: "Email/Password is empty", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else{
//                let alert = UIAlertController(title: "Error", message: "Not valid email", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
      //}
>>>>>>> origin/sophia
            }
        }
    }
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "introVideo"){
            let destinationVC = segue.destination as! DemoVideosViewController
            destinationVC.email = emailinfo
        }
    }
}
