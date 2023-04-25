//
//  MainPageViewController.swift
//  GUM-ios
//
//

import UIKit
import UserNotifications
import Firebase
import SafariServices

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

    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "storedEmail")
        UserDefaults.standard.set(nil, forKey: "storedPassword")
        //UIApplication.shared.unregisterForRemoteNotifications()
        NotificationCenter.default.removeObserver(self)
        self.performSegue(withIdentifier: "toLogin", sender: nil)
        
    }

    @IBOutlet weak var pointsLabel: UILabel!
    
    // this is the users email that will be used to pull info about them
    var email: String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAppDidBecomeActiveNotification(notification:)),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        let docRef = db.collection("Users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]//access points for user

                let stringPoints = String(pointsStored as! Int)

                self.pointsLabel.text = stringPoints

                let schedule = data?["Schedule"] as! NSArray
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
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
                //print("NOTIFICATION TEST \(UserDefaults.standard.string(forKey: "notifTest") as Any)")
                
            }

        }
        
    }
    

        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//  This was for Notification Testing
//        let center = UNUserNotificationCenter.current()
//        center.getPendingNotificationRequests(completionHandler: { requests in
//            for _ in requests {
//                print(requests.count)
//                //print("testing")
//                //print(request)
//            }
//        })
        
        let docRef = db.collection("Users").document(email)
        var notifPressed = UserDefaults.standard.string(forKey: "notifPressed")
        print("notif pressed = \(String(describing: notifPressed))")
        docRef.getDocument { (document, error) in
                   if let document = document, document.exists {

                let data = document.data()
                let pointsStored = data?["Points"]//access points for user

                let stringPoints = String(pointsStored as! Int)

                self.pointsLabel.text = stringPoints
                
                

                if (notifPressed != nil)
                {
                    UserDefaults.standard.set(nil, forKey: "notifPressed")
                    notifPressed = nil;
                    self.performSegue(withIdentifier: "mainToMove", sender: document)
                }
            }

        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), primaryAction: nil, menu: menuItems())
    }
    
    func menuItems() -> UIMenu {
        
        let addMenuItems = UIMenu(title: "", options: .displayInline, children: [
            
            UIAction(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right")) { (_) in
                print("Logout")
                UserDefaults.standard.set(nil, forKey: "storedEmail")
                UserDefaults.standard.set(nil, forKey: "storedPassword")
                //UIApplication.shared.unregisterForRemoteNotifications()
                NotificationCenter.default.removeObserver(self)
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            },
            UIAction(title: "GUM Website", image: UIImage(systemName: "safari")) { (_) in
                print("Website")
                let vc = SFSafariViewController(url: URL(string: "https://getupandmove.net/index.html")!)
                self.present(vc, animated: true)
            },
            UIAction(title: "Contact", image: UIImage(systemName: "person")) { (_) in
                print("Contact")
                let vc = SFSafariViewController(url: URL(string: "https://getupandmove.net/pages/contact.html")!)
                self.present(vc, animated: true)
            },
            UIAction(title: "About", image: UIImage(systemName: "questionmark")) { (_) in
                print("About")
                let vc = SFSafariViewController(url: URL(string: "https://www.markangelhealingarts.com/about.html")!)
                self.present(vc, animated: true)
            },
            UIAction(title: "Donate", image: UIImage(systemName: "dollarsign")) { (_) in
                print("Donate")
                let vc = SFSafariViewController(url: URL(string: "https://getupandmove.net/pages/contact.html")!)
                self.present(vc, animated: true)
            }
        
        ])
        
        return addMenuItems
        
    }


    //send email to other viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "mainToGroup":
            let destinationVC = segue.destination as! GroupLandingViewController
            destinationVC.email = email
            break;
        case "mainToUpdateScheduleV2":
            let destinationVC = segue.destination as! UpdateScheduleViewControllerV2
            destinationVC.email = email
        case "mainToMove":
            let destinationVC = segue.destination as! StartMovingViewController
            destinationVC.email = email
        case "mainToVideoDemosV2":
            let destinationVC = segue.destination as! VideoDemosViewControllerV2
            destinationVC.email = email
        default:
            print("MainPageVC Switch Block Error")
        }
        
    }
    

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
        print("App reopened")
        let docRef = db.collection("Users").document(email)
        var notifPressed = UserDefaults.standard.string(forKey: "notifPressed")
        print("notif pressed = \(String(describing: notifPressed))")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if (notifPressed != nil)
                {
                    UserDefaults.standard.set(nil, forKey: "notifPressed")
                    notifPressed = nil;
                    self.performSegue(withIdentifier: "mainToMove", sender: document)
                }
            }
        }
    }
    deinit {
        print("Uninitialized")
       NotificationCenter.default.removeObserver(self)
    }
    
}
