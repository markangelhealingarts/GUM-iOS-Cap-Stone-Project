//
//  UpdateScheduleViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/4/22.
//

import UIKit
import Firebase

class UpdateScheduleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!

    @IBOutlet weak var workout1Label: UILabel!
    @IBOutlet weak var workout2Label: UILabel!
    @IBOutlet weak var workout3Label: UILabel!
    @IBOutlet weak var workout4Label: UILabel!
    @IBOutlet weak var workout5Label: UILabel!
    @IBOutlet weak var workout6Label: UILabel!



    var email: String = ""

    var pickerData: [String] = [String]()

    var workout1: String = ""
    var workout2: String = ""
    var workout3: String = ""
    var workout4: String = ""
    var workout5: String = ""
    var workout6: String = ""

    var selectedWorkout: String = "Workout 1"

    var workouts: [String] = []

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self

        pickerData = ["Workout 1","Workout 2","Workout 3","Workout 4","Workout 5", "Workout 6"]


        let docRef = db.collection("Users").document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() //access the data
                let schedule = data?["Schedule"] as! NSArray

//                print(schedule)

                self.workout1 = (schedule[0] as? String)!
                self.workout2 = (schedule[1] as? String)!
                self.workout3 = (schedule[2] as? String)!
                self.workout4 = (schedule[3] as? String)!
                self.workout5 = (schedule[4] as? String)!
                self.workout6 = (schedule[5] as? String)!

                self.workout1Label.text = self.workout1
                self.workout2Label.text = self.workout2
                self.workout3Label.text = self.workout3
                self.workout4Label.text = self.workout4
                self.workout5Label.text = self.workout5
                self.workout6Label.text = self.workout6

            } else {
                print("Error: \(String(describing: error))")
            }
        }

    }


    // shows the correct picker data

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWorkout = pickerData[row];
    }



    @IBAction func onUpdateSchedule(_ sender: Any) {
        workouts = [workout1, workout2, workout3, workout4, workout5, workout6]

        //convert workout times to military to check if times are 1 hour apart
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let workout1Temp = dateFormatter.date(from: workout1)
        let workout2Temp = dateFormatter.date(from: workout2)
        let workout3Temp = dateFormatter.date(from: workout3)
        let workout4Temp = dateFormatter.date(from: workout4)
        let workout5Temp = dateFormatter.date(from: workout5)
        let workout6Temp = dateFormatter.date(from: workout6)
        
        print("herehere")
        print(workout1Temp)
        
        dateFormatter.dateFormat = "HH:mm"
        
        

        // changing times to 24 hour mode
        var workout1_24 = dateFormatter.string(from: workout1Temp!)
        var workout2_24 = dateFormatter.string(from: workout2Temp!)
        var workout3_24 = dateFormatter.string(from: workout3Temp!)
        var workout4_24 = dateFormatter.string(from: workout4Temp!)
        var workout5_24 = dateFormatter.string(from: workout5Temp!)
        var workout6_24 = dateFormatter.string(from: workout6Temp!)


        // remove : to check times as INTEGER
        if let i = workout1_24.firstIndex(of: ":") {
            workout1_24.remove(at: i)
        }

        if let i = workout2_24.firstIndex(of: ":") {
            workout2_24.remove(at: i)
        }

        if let i = workout3_24.firstIndex(of: ":") {
            workout3_24.remove(at: i)
        }

        if let i = workout4_24.firstIndex(of: ":") {
            workout4_24.remove(at: i)
        }

        if let i = workout5_24.firstIndex(of: ":") {
            workout5_24.remove(at: i)
        }

        if let i = workout6_24.firstIndex(of: ":") {
            workout6_24.remove(at: i)
        }
        //

        var check = false;
        if (Int(workout1_24)! + 100) <= Int(workout2_24)! {

            if (Int(workout2_24)! + 100) <= Int(workout3_24)!{

                if (Int(workout3_24)! + 100) <= Int(workout4_24)! {

                    if (Int(workout4_24)! + 100) <= Int(workout5_24)! {

                        if (Int(workout5_24)! + 100) <= Int(workout6_24)! {
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
                        "Schedule": self.workouts
                    ])

                    self.showAlert(name: "Success", message: "Your schedule has been updated")

                    let center = UNUserNotificationCenter.current()
                    center.removeAllPendingNotificationRequests()

                    for time in self.workouts{
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

                            print("\(temp):   \(String(describing: hour))")
                            print("\(temp):   \(String(describing: minute))")
                            dateComponents.hour = hour
                            dateComponents.minute = minute
                        } else {
                            var hour = Int(temp[0..<2])
                            let minute = Int(temp[3..<5])

                            if temp[6..<8] == "PM" && temp[0..<2] != "12" {
                                hour! = hour! + 12
                            }

                            print("\(temp):   \(String(describing: hour))")
                            print("\(temp):   \(String(describing: minute))")
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

                    center.getPendingNotificationRequests(completionHandler: { requests in
                        for request in requests {
                            print(request)
                        }
                    })

                } else {
                    print("Error: \(String(describing: error))")
                }
            }
        }
    }


    @IBAction func onAddTime(_ sender: Any) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)

        var hour = components.hour! > 12 ? components.hour! - 12 : components.hour!

        //this is an if statement if hour is = to 0 then 12 else it is equal to hour.
        hour = hour == 0 ? 12 : hour

        let hourString = "\(hour)"
        let minutes = components.minute! > 9 ? "\(components.minute!)" : "0\(components.minute!)"

        //this is an if statement if am is > then am is pm if < than it is am.
        let am = components.hour! >= 12 ? "PM" : "AM"

        // add to specific work out
        if selectedWorkout == "Workout 1"{
            workout1 = "\(hourString):\(minutes) \(am)"
            workout1Label.text = workout1
        } else if selectedWorkout == "Workout 2" {
            workout2 = "\(hourString):\(minutes) \(am)"
            workout2Label.text = workout2
        } else if selectedWorkout == "Workout 3" {
            workout3 = "\(hourString):\(minutes) \(am)"
            workout3Label.text = workout3
        } else if selectedWorkout == "Workout 4" {
            workout4 = "\(hourString):\(minutes) \(am)"
            workout4Label.text = workout4
        } else if selectedWorkout == "Workout 5" {
            workout5 = "\(hourString):\(minutes) \(am)"
            workout5Label.text = workout5
        } else if selectedWorkout == "Workout 6" {
            workout6 = "\(hourString):\(minutes) \(am)"
            workout6Label.text = workout6
        }

        workouts = [workout1, workout2, workout3, workout4, workout5, workout6]

//        print(workouts)
    }
}

// shows alert
extension UIViewController {
  func showAlert(name: String, message: String) {
    let alertController = UIAlertController(title: name, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
