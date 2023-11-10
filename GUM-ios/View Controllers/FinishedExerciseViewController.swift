//
//  FinishedExerciseViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 5/8/22.
//

import UIKit
import Firebase

class FinishedExerciseViewController: UIViewController {
    
    var email: String = ""
    let db = Firestore.firestore()

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]
                let streak = data?["Streak"]
                
                let stringPoints = String(pointsStored as! Int)
                let stringStreak = String(streak as! Int)

                self.pointsLabel.text = stringPoints
                self.streakLabel.text = stringStreak

            }
            
        }
    }

    @IBAction func onMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "exerciseToMain", sender: nil)
    }
}
