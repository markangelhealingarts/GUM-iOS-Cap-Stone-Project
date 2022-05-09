//
//  CurrentGroupsViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit
import Firebase

class CurrentGroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var email: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonControl: UISegmentedControl!
    
    let db = Firestore.firestore()

    var groups: [String] = []
    var lead: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonControl.addTarget(self, action: #selector(CurrentGroupsViewController.indexChanged(_:)), for: .valueChanged)
        
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let groupTemp = data!["Groups"] as! NSArray

                for group in groupTemp {
                    
                    let groupRef = self.db.collection("Groups").document(group as! String)
                    groupRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            
                            let data1 = document.data()
                            if data1!["Leader Name"] as! String == self.email {
                                self.lead.append("\(document.documentID)")
                            } else {
                                self.groups.append("\(document.documentID)")
                            }

                        } else {
                            print("ERROR: \(String(describing: error))")
                        }
                    }

                }

                self.tableView.delegate = self
                self.tableView.dataSource = self

            } else {
                print("ERROR: \(String(describing: error))")
            }
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if buttonControl.selectedSegmentIndex == 0 {
            tableView.reloadData()
        } else if buttonControl.selectedSegmentIndex == 1 {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonControl.selectedSegmentIndex == 0 {
            return groups.count
        } else {
            return lead.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        if buttonControl.selectedSegmentIndex == 0 {
            let docRef = db.collection("Groups").document(groups[indexPath.row])
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    cell.groupNameLabel.text = data!["Group Name"] as? String

                    let members = data!["Members"] as! NSArray
                    cell.membersLabel.text = "\(members.count)"

                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
        } else {
            let docRef = db.collection("Groups").document(lead[indexPath.row])
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    
                    if data!["Leader Name"] as! String == self.email {
                        cell.groupNameLabel.text = data!["Group Name"] as? String

                        let members = data!["Members"] as! NSArray
                        cell.membersLabel.text = "\(members.count)"

                    }
                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "groupToDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "groupToDetail" {
            if buttonControl.selectedSegmentIndex == 0 {
                let destinationVC = segue.destination as! ClickedGroupViewController
                destinationVC.email = email
                destinationVC.groupName = groups[sender as! Int]
                destinationVC.isLeader = false
            } else if buttonControl.selectedSegmentIndex == 1 {
                let destinationVC = segue.destination as! ClickedGroupViewController
                destinationVC.email = email
                destinationVC.groupName = lead[sender as! Int]
                destinationVC.isLeader = true
            }

        }
    }
}
