//
//  ExerciseVideoViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/21/22.
//

import UIKit
import Firebase
import youtube_ios_player_helper

class ExerciseVideoViewController: UIViewController, YTPlayerViewDelegate{


    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var finishedBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!


    var email: String = ""
    var selectedPicker: String = ""
    var difficulty: String = ""
    var desc: String = ""

    let db = Firestore.firestore()
    let currVideoID = ""
    var videoIDList = [Any]()
    var finishedVideosArray = [Any]()

    var timer: Timer!
    var secondsRemaining = 59
    var minutesRemaining = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        finishedBtn.layer.opacity = 0
        playerView.delegate = self

        db.collection("StartMoving").document(difficulty).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()

                let videos = data!["Titles"] as! NSArray
                print(videos)
                let tempVideoIDList = data!["YtUrls"] as! [Any]
                self.videoIDList = tempVideoIDList

                var count = 0

                for video in videos {
                    if video as! String == self.selectedPicker {

                        let descTemp = data!["Descriptions"] as! NSArray
                        self.desc = descTemp[count] as! String

                        let urls = data!["YtUrls"] as! NSArray
                        print(urls[count] as! String)
//                        self.playerView.load(withVideoId: urls[count] as! String)
                        self.playerView.load(withVideoId: self.videoIDList[count] as! String)
                        self.descriptionLabel.text = self.desc
                        
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCountDown), userInfo: nil, repeats: true)
                        
                        break
                    }
                    count += 1
                }

            } else {
                print("Error: \(String(describing: error))")
            }
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
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
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let todaysDate : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date)
        print(todaysDate)
        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]
                let streak = data?["Streak"]
                
                var previousDate: String = ""
                previousDate = data?["Last Update"] as! String
                if (!(previousDate.isEmpty)){
                    print("Previous Date: \(String(describing: previousDate))")
                    let prevDay = self.getDayFromDate(tempDate: previousDate)
                    let prevMonth = self.getMonthFromDate(tempDate: previousDate)
                    print("Prev day: \(prevDay)")
                    print("Prev month: \(prevMonth)")
                    let currDay = self.getDayFromDate(tempDate: todaysDate)
                    let currMonth = self.getMonthFromDate(tempDate: todaysDate)
                    
                    if(currMonth - prevMonth == 0){
                        if ((currDay - prevDay) == 1){
                            docRef.updateData(["Streak": streak as! Int + 1])
                        }else if(prevDay==currDay){
                            print("SAME DAY")
                        }
                        else {
                            docRef.updateData(["Streak": 1])
                        }
                    }
                    else if (currMonth - prevMonth == 1){
                        if ((currDay - prevDay) <= -27){
                            docRef.updateData(["Streak": streak as! Int + 1])
                        }
                        else {
                            print("Streak: Month Changed Streak Reset")
                            docRef.updateData(["Streak": 1])
                        }
                    }
                    else{
                        print("Streak: Months Passed Streak Reset")
                        docRef.updateData(["Streak": 1])
                    }
                }
                else{
                    print("Streak: New To App")
                    docRef.updateData(["Streak": 1])
                }
                docRef.updateData([
                    "Points": pointsStored as! Int + 10,
                    "Last Update": todaysDate
                ])
                
                
                
                //if()

                self.performSegue(withIdentifier: "exerciseToFinished", sender: nil)
            }

        }
    }
    
    func getDayFromDate(tempDate: String) -> Int{
        print(tempDate.dropLast(6))
        return Int(tempDate.dropLast(6))!
    }
    
    func getMonthFromDate(tempDate: String) -> Int{
        print(tempDate)
        return Int(tempDate.dropLast(3).dropFirst(3))!
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "exerciseToFinished" {
            let destinationVC = segue.destination as! FinishedExerciseViewController
            destinationVC.email = email
        }
    }
    
}
