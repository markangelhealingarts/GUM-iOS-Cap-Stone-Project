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
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var memberPointsTitle: UILabel!
    @IBOutlet weak var memberPointsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLeader {
            //only show for member of group not the leader
            memberPointsTitle.layer.opacity = 0
            memberPointsLabel.layer.opacity = 0
        }
        
        let docRef = db.collection("Groups").document(groupName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                self.groupNameLabel.text = data!["Group Name"] as? String
                self.pointGoal = data!["Point Goal"] as! Int
                
                let memberRef = self.db.collection("Groups").document(self.groupName).collection(self.groupName).document("Info")
                
                memberRef.getDocument { (memberDoc, error) in
                    if let memberDoc = memberDoc, memberDoc.exists {
                        let memberData = memberDoc.data()
                        
                        let members = memberData!["Members"] as! NSArray
                        for member in members {
                            self.members.append(member as! String)
                        }
                        
                        print(self.members)
                        
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                    } else {
                        print("ERROR: \(String(describing: error))")
                    }
                }
                
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
}
