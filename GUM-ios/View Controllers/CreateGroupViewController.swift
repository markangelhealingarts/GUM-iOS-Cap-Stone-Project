//
//  CreateGroupViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit
import Firebase

class CreateGroupViewController: UIViewController {
    
    var email: String = ""
    var randomCode: String = ""
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pointGoalTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func onCreateGroup(_ sender: Any) {
        let groupName = groupNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        let goal = (pointGoalTextField.text?.trimmingCharacters(in: .whitespaces))!
        
        self.view.endEditing(true)
        
        
        if groupName == "" {
            let alert = UIAlertController(title: "Error", message: "Enter group name!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if password == "" {
            let alert = UIAlertController(title: "Error", message: "Enter password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if goal == "" {
            let alert = UIAlertController(title: "Error", message: "Enter a goal!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let documentNum = random(digits: 6)
            
            randomCode = documentNum
            
            db.collection("Groups").document(documentNum).setData([
                "Group": Int(documentNum)!,
                "Group Name": groupName!,
                "Leader Name": email,
                "Point Goal": Int(goal)!,
                "Members": [],
                "Password": password!
            ])
            
            let docRef = db.collection("Users").document(email)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data() //access the data
                    let groupsApartOf = data!["Groups"] as! NSArray
                    
                    var groups: [String] = []
                    for groupNum in groupsApartOf {
                        groups.append(groupNum as! String)
                    }
                    groups.append(documentNum)
                    
                    self.db.collection("Users").document(self.email).updateData([
                        "Groups": groups
                    ])
                    
                    self.performSegue(withIdentifier: "createToDetail", sender: nil)

                } else {
                    
                    let alert = UIAlertController(title: "Error", message: "Email doesn't exist", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "createToDetail" {
            let destinationVC = segue.destination as! CreateDetailViewController
            destinationVC.email = email
            destinationVC.inviteCode = randomCode
        }
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}
