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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docRef = db.collection("Users").document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                self.groups = data!["Groups"] as! [String]

            } else {
                print("ERROR: \(String(describing: error))")
            }
        }

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! GroupCell
        
        return cell
    }
    
    
}
