//
//  AboutGroupsViewController.swift
//  GUM-ios
//
//  Created by Ryan Pheang on 4/12/23.
//

import UIKit
import SafariServices

class AboutGroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func buttonTapped() {
        
        let vc = SFSafariViewController(url: URL(string: "https://getupandmove.net/pages/contact.html")!)
        present(vc, animated: true)
    }
    

}
