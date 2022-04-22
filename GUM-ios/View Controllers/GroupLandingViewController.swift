//
//  GroupLandingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit

class GroupLandingViewController: UIViewController {
    
    var email: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onCreateGroup(_ sender: Any) {
        performSegue(withIdentifier: "groupToCreate", sender: nil)
    }
    
    
    @IBAction func onJoinGroup(_ sender: Any) {
        performSegue(withIdentifier: "groupToJoin", sender: nil)
    }
    
    
    @IBAction func onCurrentGroups(_ sender: Any) {
        performSegue(withIdentifier: "groupToCurrent", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "groupToCreate" {
            let destinationVC = segue.destination as! CreateGroupViewController
            destinationVC.email = email
        } else if segue.identifier == "groupToJoin" {
            let destinationVC = segue.destination as! JoinGroupViewController
            destinationVC.email = email
        } else if segue.identifier == "groupToCurrent" {
            let destinationVC = segue.destination as! CurrentGroupsViewController
            destinationVC.email = email
        }
    }
}
