//
//  UpdateScheduleViewControllerV2.swift
//  GUM-ios
//
//  Created by Ryan Pheang on 3/8/23.
//

import UIKit
import Firebase

class UpdateScheduleViewControllerV2: UIViewController {
    
    @IBOutlet private weak var buttonTime1: UIButton!
    @IBOutlet weak var buttonTime2: UIButton!
    @IBOutlet weak var buttonTime3: UIButton!
    @IBOutlet weak var buttonTime4: UIButton!
    @IBOutlet weak var buttonTime5: UIButton!
    @IBOutlet weak var buttonTime6: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var buttonAddTime: UIButton!
    
    var email: String = ""
    let db = Firestore.firestore()
    
    var timeArray: [String] = []
    var time1: String = ""
    var time2: String = ""
    var time3: String = ""
    var time4: String = ""
    var time5: String = ""
    var time6: String = ""
    
    
    
    var currentTimeSelected: String = "time1"

    override func viewDidLoad() {
        super.viewDidLoad()
        addTimesToButtons()
    }
    
// Function pulls information from database to fill in the labels of the button with the user's current schedule
    
    func addTimesToButtons() {
//        Pull all of current user's info from database
        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() //access the data
                let schedule = data?["Schedule"] as! NSArray
                
//                print(schedule)
                
                self.time1 = (schedule[0] as? String)!
                self.time2 = (schedule[1] as? String)!
                self.time3 = (schedule[2] as? String)!
                self.time4 = (schedule[3] as? String)!
                self.time5 = (schedule[4] as? String)!
                self.time6 = (schedule[5] as? String)!
                
                self.buttonTime1.setTitle(self.time1, for: .normal)
                self.buttonTime2.setTitle(self.time2, for: .normal)
                self.buttonTime3.setTitle(self.time3, for: .normal)
                self.buttonTime4.setTitle(self.time4, for: .normal)
                self.buttonTime5.setTitle(self.time5, for: .normal)
                self.buttonTime6.setTitle(self.time6, for: .normal)

            } else {
                print("Error: \(String(describing: error))")
            }
        }

    }
    
    fileprivate func checkTimePickerVisibility() {
        //        check if timePicker and addTime is hidden. Show if currently hidden
        if timePicker.isHidden == true {
            timePicker.isHidden = false
            buttonAddTime.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @IBAction func onTime1Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time1"
        buttonTime1.setTitle(time1, for: .normal)
    }
    @IBAction func onTime2Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time2"
        buttonTime2.setTitle(time2, for: .normal)
    }
    @IBAction func onTime3Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time3"
        buttonTime3.setTitle(time3, for: .normal)
    }
    @IBAction func onTime4Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time4"
        buttonTime4.setTitle(time4, for: .normal)
    }
    @IBAction func onTime5Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time5"
        buttonTime5.setTitle(time5, for: .normal)
    }
    @IBAction func onTime6Tap(_ sender: Any) {
        checkTimePickerVisibility()
        currentTimeSelected = "time6"
        buttonTime6.setTitle(time6, for: .normal)

    }
    
    @IBAction func onNavBarItemUpdateTap(_ sender: Any) {
        timeArray = [time1, time2, time3, time4, time5, time6]
        print("Horse1")
        print(timeArray)
        
//        print("nav bar update button clicked")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h:mm a"
        
        let tempTime1 = dateFormatter.date(from: time1)
        let tempTime2 = dateFormatter.date(from: time2)
        let tempTime3 = dateFormatter.date(from: time3)
        let tempTime4 = dateFormatter.date(from: time4)
        let tempTime5 = dateFormatter.date(from: time5)
        let tempTime6 = dateFormatter.date(from: time6)
        
        dateFormatter.dateFormat = "HH:mm"
        
        var time1_24 = dateFormatter.string(from: tempTime1!)
        var time2_24 = dateFormatter.string(from: tempTime2!)
        var time3_24 = dateFormatter.string(from: tempTime3!)
        var time4_24 = dateFormatter.string(from: tempTime4!)
        var time5_24 = dateFormatter.string(from: tempTime5!)
        var time6_24 = dateFormatter.string(from: tempTime6!)

        
        // remove : to check times as INTEGER
        if let i = time1_24.firstIndex(of: ":") {
            time1_24.remove(at: i)
        }

        if let i = time2_24.firstIndex(of: ":") {
            time2_24.remove(at: i)
        }

        if let i = time3_24.firstIndex(of: ":") {
            time3_24.remove(at: i)
        }

        if let i = time4_24.firstIndex(of: ":") {
            time4_24.remove(at: i)
        }

        if let i = time5_24.firstIndex(of: ":") {
            time5_24.remove(at: i)
        }

        if let i = time6_24.firstIndex(of: ":") {
            time6_24.remove(at: i)
        }
        //

        var check = false;
        if (Int(time1_24)! + 100) <= Int(time2_24)! {
            if (Int(time2_24)! + 100) <= Int(time3_24)!{
                if (Int(time3_24)! + 100) <= Int(time4_24)! {
                    if (Int(time4_24)! + 100) <= Int(time5_24)! {
                        if (Int(time5_24)! + 100) <= Int(time6_24)! {
                            check = true
                        } else {
                            showAlert(name: "Error", message: "Your 5th must be spaced out by at least 1 hour!")
                        }

                    } else {
                        showAlert(name: "Error", message: "Your 4th must be spaced out by at least 1 hour!")
                    }
                } else {
                    showAlert(name: "Error", message: "Your 3rd must be spaced out by at least 1 hour!")
                }
            } else {
                showAlert(name: "Error", message: "Your 2nd must be spaced out by at least 1 hour!")
            }
        } else {
            showAlert(name: "Error", message: "Your 1st must be spaced out by at least 1 hour!")
        }

        //if checks are okay, add times into Firebase

        if(check){
            print("WORKING")

            let docRef = db.collection("Users").document(email)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {

                    docRef.updateData([
                        "Schedule": self.timeArray
                    ])

                    self.showAlert(name: "Success", message: "Your schedule has been updated")

                    let center = UNUserNotificationCenter.current()
                    center.removeAllPendingNotificationRequests()

                    for time in self.timeArray{
                        let randomIdentifier = UUID().uuidString

                        var dateComponents = DateComponents()
                        dateComponents.calendar = Calendar.current

                        let temp = time
                        if temp.count == 7 {
                            var hour = Int(temp[0])
                            let minute = Int(temp[2..<4])


                            if temp[5..<7] == "PM" {
                                hour! = hour! + 12
                            }

//                            print("\(temp):   \(String(describing: hour))")
//                            print("\(temp):   \(String(describing: minute))")
                            dateComponents.hour = hour
                            dateComponents.minute = minute
                        } else {
                            var hour = Int(temp[0..<2])
                            let minute = Int(temp[3..<5])

                            if temp[6..<8] == "PM" && temp[0..<2] != "12" {
                                hour! = hour! + 12
                            }

//                            print("\(temp):   \(String(describing: hour))")
//                            print("\(temp):   \(String(describing: minute))")
                            dateComponents.hour = hour
                            dateComponents.minute = minute
                        }



                        let content = UNMutableNotificationContent()
                        content.title = "Get Up and Move"
                        content.body = "Start your next session!"
                        content.sound = .default

                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
                        //print("test")
                        
                        center.add(request)
                        print("added request")
                        
                    }

                    center.getPendingNotificationRequests(completionHandler: { requests in
                        for request in requests {
                            print(requests.count)
                            //print("testing")
                            print(request)
                        }
                    })

                } else {
                    print("Error: \(String(describing: error))")
                }
            }
        }
    }
    
    @IBAction func onButtonAddTimeTap(_ sender: Any) {
//        print("Add Time Button To: " + currentTimeSelected)
        let components = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)

        var hour = components.hour! > 12 ? components.hour! - 12 : components.hour!

        //this is an if statement if hour is = to 0 then 12 else it is equal to hour.
        hour = hour == 0 ? 12 : hour

        let hourString = "\(hour)"
        let minutes = components.minute! > 9 ? "\(components.minute!)" : "0\(components.minute!)"

        //this is an if statement if am is > then am is pm if < than it is am.
        let am = components.hour! >= 12 ? "PM" : "AM"
            
        switch currentTimeSelected{
        case "time1":
            time1 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime1.setTitle(time1, for: .normal)
        case "time2":
            time2 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime2.setTitle(time2, for: .normal)
        case "time3":
            time3 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime3.setTitle(time3, for: .normal)
        case "time4":
            time4 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime4.setTitle(time4, for: .normal)
        case "time5":
            time5 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime5.setTitle(time5, for: .normal)
        case "time6":
            time6 = ("\(hourString):\(minutes) \(am)")
            self.buttonTime6.setTitle(time6, for: .normal)
        default:
            print("UpdateScheduleVCV2 Switch Block Error")
        }
        
        timeArray = [time1, time2, time3, time4, time5, time6]
        print("panda10")
        print(timeArray)
    }
}

extension UIViewController {
    func showAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in}))
        self.present(alertController, animated: true, completion: nil)
    }
}
