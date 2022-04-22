//
//  CreateDetailViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 4/20/22.
//

import UIKit

class CreateDetailViewController: UIViewController {
    
    var email: String = ""
    var inviteCode: String = ""
    
    @IBOutlet weak var codeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeLabel.text = inviteCode
    }
    
    
    @IBAction func onReturn(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: email)
    }
}
