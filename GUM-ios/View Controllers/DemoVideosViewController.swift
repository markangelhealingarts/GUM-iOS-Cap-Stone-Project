//
//  DemoVideosViewController.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 4/22/22.
//
import Foundation
import UIKit
import youtube_ios_player_helper_swift
import YouTubePlayer
import Firebase

class DemoVideosViewController: UIViewController{
    var once = true
    var timer: Timer?
    var email: String = ""
    let db = Firestore.firestore()
    @IBOutlet var youtubePlayer: YouTubePlayerView!
    override func viewDidLoad() {
        if once {
            youtubePlayer.loadVideoID("frFlcZ1Xnno")
            once = false
            print(email)
            //youtubePlayer.seekTo(60, seekAhead: false)
            //115 time
//            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            
            
        }else{
            print("close")
            once = false
        }
        

    }
    @IBAction func startOrientationVideo(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://getupandmove.net/GUM/GUM_Orientation/index.html")! as URL)
    }
    @objc func update(){
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document,error) in
            if let document = document, document.exists {
                self.performSegue(withIdentifier: "pickerLevel", sender: document)
            }
            
        }
    }
    @IBAction func surveyPage(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document,error) in
            if let document = document, document.exists {
                self.performSegue(withIdentifier: "pickerLevel", sender: document)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "pickerLevel"){
            let destinationVC = segue.destination as! SurveyViewController
            destinationVC.email = email
        }
    }
    
}
