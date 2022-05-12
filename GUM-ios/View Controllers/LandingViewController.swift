//
//  LandingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 5/11/22.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        performSegue(withIdentifier: "landingToTerms", sender: nil)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        performSegue(withIdentifier: "landingToLogin", sender: nil)
    }
    
}
