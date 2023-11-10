//
//  GroupLandingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit
import SafariServices

class GroupLandingViewController: UIViewController {
    var email: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onCreateGroup(_ sender: Any) {

                
                if(UserDefaults.standard.string(forKey: "storedEmail") == "markangelhealingarts@gmail.com"){
                    performSegue(withIdentifier: "groupToCreate", sender: nil)
                }
                else {
                    let vc = SFSafariViewController(url: URL(string: "https://www.paypal.com/paypalme/getupandmove?country.x=US&locale.x=en_US")!)
                    present(vc, animated: true)
                }
        
    }
    
    
    @IBAction func onJoinGroup(_ sender: Any) {
        performSegue(withIdentifier: "groupToJoin", sender: nil)
    }
    
    
    @IBAction func onCurrentGroups(_ sender: Any) {
        performSegue(withIdentifier: "groupToCurrent", sender: nil)
    }
    
    @IBAction func buttonTapped() {
        let vc = SFSafariViewController(url: URL(string: "https://www.paypal.com/paypalme/getupandmove?country.x=US&locale.x=en_US")!)
        present(vc, animated: true)
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
