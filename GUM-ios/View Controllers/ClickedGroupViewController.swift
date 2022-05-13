//
//  ClickedGroupViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 5/4/22.
//

import UIKit
import Firebase

class ClickedGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var email: String = ""
    var groupName: String = ""
    var isLeader: Bool = false
    
    var members: [String] = []
    
    var pointGoal: Int = 0
    var userPoints: Int = 0
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var memberPointsTitle: UILabel!
    @IBOutlet weak var memberPointsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leaveGroupBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLeader {
            //only show for member of group not the leader
            memberPointsTitle.layer.opacity = 0
            memberPointsLabel.layer.opacity = 0
            leaveGroupBtn.tintColor = UIColor.clear
        }
        
        let docRef = db.collection("Groups").document(groupName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                self.groupNameLabel.text = data!["Group Name"] as? String
                self.pointGoal = data!["Point Goal"] as! Int

                let personRef = self.db.collection("Users").document(self.email)
                personRef.getDocument { (personDocument, error) in
                    if let personDocument = personDocument, personDocument.exists {
                        
                        let data = personDocument.data()
                        self.userPoints = data!["Points"] as! Int
                        self.memberPointsLabel.text = "\(self.userPoints)/\(self.pointGoal)"

                    } else {
                        print("ERROR: \(String(describing: error))")
                    }
                }

                let members = data!["Members"] as! NSArray
                for member in members {
                    self.members.append(member as! String)
                }
                
                self.tableView.delegate = self
                self.tableView.dataSource = self

            } else {
                print("ERROR: \(String(describing: error))")
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as! MemberCell
        
        cell.nameLabel.text = members[indexPath.row]
        
        let docRef = db.collection("Users").document(members[indexPath.row])
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                cell.pointsLabel.text = "\(data!["Points"] as! Int)/\(self.pointGoal)"

            } else {
                print("ERROR: \(String(describing: error))")
            }
        }
        
        return cell
    }
    
    
    @IBAction func onLeaveGroup(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Leave Group", message: "Are you sure?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            let docRef = self.db.collection("Groups").document(self.groupName)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    let membersTemp = data!["Members"] as! NSArray
                    
                    var newMembers: [String] = []
                    
                    for member in membersTemp {
                        if member as! String != self.email {
                            newMembers.append(member as! String)
                        }
                    }
                    
                    self.db.collection("Groups").document(self.groupName).updateData([
                        "Members": newMembers
                    ])

                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            
            let personRef = self.db.collection("Users").document(self.email)
            personRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    let groupsTemp = data!["Groups"] as! NSArray
                    
                    var newGroups: [String] = []
                    
                    for group in groupsTemp {
                        if group as! String != self.groupName {
                            newGroups.append(group as! String)
                        }
                    }
                    
                    self.db.collection("Users").document(self.email).updateData([
                        "Groups": newGroups
                    ])

                    self.performSegue(withIdentifier: "groupToMain", sender: nil)
                    self.showAlert(name: "Success", message: "Successfully Left Group!")

                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle response here.
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
