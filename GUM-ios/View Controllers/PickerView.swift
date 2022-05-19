//
//  PickerView.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 5/5/22.
//

import UIKit
//import youtube_ios_player_helper_swift
import Firebase
class PickerView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    let db = Firestore.firestore()
    var email: String = ""
    var myPain: String = ""
    @IBOutlet weak var levelPicker: UIPickerView!
    let levels = ["Select Level", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        levelPicker.dataSource = self
        levelPicker.delegate = self
        
    }
    
    @IBAction func btnFunctions(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ (document, error) in
                           if let document = document, document.exists {
                               self.performSegue(withIdentifier: "picker3", sender: document)
            }
        }
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "picker3"){
            let destinationVC = segue.destination as! SurveryPicker
            destinationVC.email = email
        }
    }
}
