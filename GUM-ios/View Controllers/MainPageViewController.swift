//
//  MainPageViewController.swift
//  GUM-ios
//
//

import UIKit
import UserNotifications
import Firebase

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

class MainPageViewController: UIViewController {

    var email: String = "" // this is the users email that will be used to pull info about them

    @IBOutlet weak var pointsLabel: UILabel!

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]//access points for user

                let stringPoints = String(pointsStored as! Int)

                self.pointsLabel.text = stringPoints

                let schedule = data?["Schedule"] as! NSArray
                let center = UNUserNotificationCenter.current()

                for time in schedule{
                    let randomIdentifier = UUID().uuidString

                    var dateComponents = DateComponents()
                    dateComponents.calendar = Calendar.current

                    let temp = time as! String
                    if temp.count == 7 {
                        var hour = Int(temp[0])
                        let minute = Int(temp[2..<4])


                        if temp[5..<7] == "PM" {
                            hour! = hour! + 12
                        }
                        dateComponents.hour = hour
                        dateComponents.minute = minute
                    } else {
                        var hour = Int(temp[0..<2])
                        let minute = Int(temp[3..<5])

                        if temp[6..<8] == "PM" && temp[0..<2] != "12" {
                            hour! = hour! + 12
                        }
                        dateComponents.hour = hour
                        dateComponents.minute = minute
                    }



                    let content = UNMutableNotificationContent()
                    content.title = "Get Up and Move"
                    content.body = "Start your next session!"
                    content.sound = .default

                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                    let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
                    center.add(request)
                }
            }

        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]//access points for user

                let stringPoints = String(pointsStored as! Int)

                self.pointsLabel.text = stringPoints
            }

        }
    }


    //send email to other viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToGroup" {
            let destinationVC = segue.destination as! GroupLandingViewController
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

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
}
