//
//  agreement.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 5/4/22.
//

import Foundation

import UIKit

class agreement: UIViewController {
    
    var email: String = ""
    @IBOutlet weak var btnCheckBox: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnCheckBox.setImage(UIImage(named: "checkEmpty"), for: .normal)
        btnCheckBox.setImage(UIImage(named: "checkIn"), for: .selected)
        
    }
    
    @IBAction func checkAgreement(_ sender: UIButton) {
        let image1 = UIImage(named: "checkIn")
        print(btnCheckBox.currentImage)
        if(image1 == btnCheckBox.currentImage){
            performSegue(withIdentifier: "passAgreement", sender: nil)
        }
    }
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "introVideo"){
            let destinationVC = segue.destination as! SurveyViewController
            destinationVC.email = email
        }
    }
}
