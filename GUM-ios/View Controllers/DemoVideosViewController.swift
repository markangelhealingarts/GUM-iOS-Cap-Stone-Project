//
//  DemoVideosViewController.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 4/22/22.
//
import Foundation
import UIKit
import youtube_ios_player_helper
import Firebase

class DemoVideosViewController: UIViewController{
    var once = true
    var timer: Timer?
    var email: String = ""
    let db = Firestore.firestore()
    
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    
    
    override func viewDidLoad() {
        if once {
            youtubePlayer.load(withVideoId: "frFlcZ1Xnno")
            once = false
        }else{
            print("close")
            once = false
        }
        

    }
    @IBAction func startOrientationVideo(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://getupandmove.net/GUM/GUM_Orientation/index.html")! as URL)
    }
    @objc func update(){
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document,error) in
            if let document = document, document.exists {
                //self.performSegue(withIdentifier: "pickerLevel", sender: document)
            }
            
        }
    }
    @IBAction func surveyPage(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document,error) in
            if let document = document, document.exists {
                //self.performSegue(withIdentifier: "pickerLevel", sender: document)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "pickerLevel2"){
            let destinationVC = (segue.destination as! UINavigationController).topViewController as! MainPageViewController
            destinationVC.email = email
        }
    }
    
    
}
