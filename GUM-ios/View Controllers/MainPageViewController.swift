//
//  MainPageViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/3/22.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {
    
    var email: String = "" // this is the users email that will be used to pull info about them
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let pointsStored = data?["Points"]//access points for user
                print(data)
                let stringPoints = String(pointsStored as! Int)
                
                let avatar = data?["AvatarUrl"]
                
                self.avatarImageView.image = UIImage(named: avatar as! String)

                self.pointsLabel.text = stringPoints
            }
            
        }
        
    }
    
    
    //send email to other viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mainToAvatar" {
            let destinationVC = segue.destination as! UnlockAvatarViewController
            destinationVC.email = email
        } else if segue.identifier == "mainToSchedule" {
            let destinationVC = segue.destination as! UpdateScheduleViewController
            destinationVC.email = email
        } else if segue.identifier == "mainToMove" {
            let destinationVC = segue.destination as! StartMovingViewController
            destinationVC.email = email
        } else if segue.identifier == "mainToDemo" {
            let destinationVC = segue.destination as! VideoDemosViewController
            destinationVC.email = email
        }
        
        
    }

}
