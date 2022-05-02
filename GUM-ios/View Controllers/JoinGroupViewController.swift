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
    }
    
    
    @IBAction func onJoin(_ sender: Any) {
        
        let code = codeTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
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
                    
                    if passwordStored == password {
                        self.addUser()
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
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
