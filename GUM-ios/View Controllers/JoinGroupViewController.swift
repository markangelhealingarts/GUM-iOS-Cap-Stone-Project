//
//  JoinGroupViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit
import Firebase

class JoinGroupViewController: UIViewController {
    
    var email: String = ""
    
    let db = Firestore.firestore()

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func onJoin(_ sender: Any) {
        
        let code = codeTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        self.view.endEditing(true)
        
        if code == "" {
            let alert = UIAlertController(title: "Error", message: "Enter invite code!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if password == "" {
            let alert = UIAlertController(title: "Error", message: "Enter password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            
            let docRef = db.collection("Groups").document(code!)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    
                    let passwordStored = data!["Password"] as! String
                    
                    let leader = data!["Leader Name"] as! String
                    
                    if leader == self.email { // in the case the leader tries to join group
                        let alert = UIAlertController(title: "Error", message: "You are the leader!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                    
                        if passwordStored == password {
                            
                            let originalMembers = data!["Members"] as! NSArray
                            
                            var check: Bool = false
                            var members: [String] = []
                            for member in originalMembers {
                                members.append(member as! String)
                                
                                if member as! String == self.email { //if user is in group already
                                    check = true
                                }
                            }
                            
                            if !check { // if user tries to join the same group
                                members.append(self.email)
                                
                                // add username to members
                                self.db.collection("Groups").document(code!).updateData([
                                    "Members": members
                                ])
                                
                                // add group into user
                                self.addUser()
                            } else {
                                let alert = UIAlertController(title: "Error", message: "Already Part of Group", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Error", message: "Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Invite Code", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func addUser (){
        
        let code = codeTextField.text?.trimmingCharacters(in: .whitespaces)
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                
                let groupsApartOf = data!["Groups"] as! NSArray
                
                var groups: [String] = []
                for groupNum in groupsApartOf {
                    groups.append(groupNum as! String)
                }
                groups.append(code!)
                
                self.db.collection("Users").document(self.email).updateData([
                    "Groups": groups
                ])
                
                self.performSegue(withIdentifier: "joinToCurrent", sender: nil)

            } else {
                let alert = UIAlertController(title: "Error", message: "Email doesn't exist", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "joinToCurrent" {
            let destinationVC = segue.destination as! CurrentGroupsViewController
            destinationVC.email = email
        }
    }
}
