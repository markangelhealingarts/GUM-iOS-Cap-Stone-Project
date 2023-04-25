//
//  LandingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 5/11/22.
//

import UIKit
import UserNotifications
import Firebase

class LandingViewController: UIViewController {
    let db = Firestore.firestore()
    //var emailInfo: String = ""
    var email = UserDefaults.standard.string(forKey: "storedEmail")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (email != nil)
        {
        let docRef = db.collection("Users").document(email!)
        
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                
                //self.emailInfo = self.email! //send this info to MainViewController
                
                    self.performSegue(withIdentifier: "skipLogin", sender: document)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "skipLogin"){
            let destinationVC = (segue.destination as! UINavigationController).topViewController as! MainPageViewController

            destinationVC.email = email!
        }

    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        performSegue(withIdentifier: "landingToTerms", sender: nil)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        performSegue(withIdentifier: "landingToLogin", sender: nil)
    }
    
}
