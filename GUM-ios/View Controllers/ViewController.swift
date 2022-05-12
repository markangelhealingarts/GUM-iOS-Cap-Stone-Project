//
//  ViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/16/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func agreementAction(_ sender: Any) {
        performSegue(withIdentifier: "agreement", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

