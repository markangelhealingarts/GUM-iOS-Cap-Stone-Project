//
//  AboutTeamsViewController.swift
//  GUM-ios
//
//  Created by Ryan Pheang on 4/24/23.
//

import UIKit
import SafariServices

class AboutTeamsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped() {
        let vc = SFSafariViewController(url: URL(string: "https://getupandmove.net/pages/contact.html")!)
        present(vc, animated: true)
    }
    
    
    

}
