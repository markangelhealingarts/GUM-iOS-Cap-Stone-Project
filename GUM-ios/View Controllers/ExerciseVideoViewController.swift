//
//  ExerciseVideoViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/21/22.
//

import UIKit
import Firebase
import youtube_ios_player_helper_swift
import YouTubePlayer

class ExerciseVideoViewController: UIViewController{


    @IBOutlet weak var countDown: UILabel!
    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet weak var finishedBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!


    var email: String = ""
    var selectedPicker: String = ""
    var difficulty: String = ""
    var desc: String = ""

    let db = Firestore.firestore()

    var timer: Timer!
    var secondsRemaining = 59
    var minutesRemaining = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        finishedBtn.layer.opacity = 0

        db.collection("StartMoving").document(difficulty).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()

                let videos = data!["Titles"] as! NSArray

                var count = 0

                for video in videos {
                    if video as! String == self.selectedPicker {

                        let descTemp = data!["Descriptions"] as! NSArray
                        self.desc = descTemp[count] as! String

                        let urls = data!["YtUrls"] as! NSArray
                        self.playerView.loadVideoID(urls[count] as! String)
                        self.playerView.play()
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCountDown), userInfo: nil, repeats: true)
                        self.descriptionLabel.text = self.desc
                    }
                    count += 1
                }

            } else {
                print("Error: \(String(describing: error))")
            }
        }
    }

    @objc func updateCountDown () {

        var seconds:Int = 0
        var minutes:Int = 0

        if secondsRemaining == 0 && minutesRemaining == 0 {
            finishedBtn.layer.opacity = 1
        } else {
            if secondsRemaining >= 0 {
                seconds = secondsRemaining
                minutes = minutesRemaining

                secondsRemaining -= 1
            } else if secondsRemaining < 0 {
                minutes = minutesRemaining - 1
                seconds = 59

                secondsRemaining = 59
                minutesRemaining -= 1
            }

            if seconds < 10 {
                countDown.text = "\(minutes):0\(seconds)"
            } else {
                countDown.text = "\(minutes):\(seconds)"
            }

        }

    }

    @IBAction func onFinishedExercise(_ sender: Any) {
        //add points to user
        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]

                docRef.updateData([
                    "Points": pointsStored as! Int + 10
                ])

                self.performSegue(withIdentifier: "exerciseToFinished", sender: nil)
            }

        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "exerciseToFinished" {
            let destinationVC = segue.destination as! FinishedExerciseViewController
            destinationVC.email = email
        }
    }
    
}
