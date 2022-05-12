//
//  PickerView2.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 5/5/22.
//

import Foundation
import UIKit
import Firebase

class SurveryPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let db = Firestore.firestore()
    var email : String = ""
    var myPain: String = ""
    @IBOutlet weak var picker: UIPickerView!
    let levels = ["Select Level", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
    }
    
    
    @IBAction func submitBtn(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document, error) in
                           if let document = document, document.exists {
                               self.performSegue(withIdentifier: "Picker", sender: document)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levels.count
    }
    
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(levels[row])
        myPain = levels[row]
        //let ref = Database.database().reference()
        //ref.child("Users/").
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "Picker"){
            let destinationVC = segue.destination as! surveryPicker2
            destinationVC.emailinfo = email
        }
    }
}
