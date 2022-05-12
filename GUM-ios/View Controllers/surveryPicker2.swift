//
//  surveryPicker2.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 5/5/22.
//

import Foundation
import Firebase
import UIKit
import Firebase

class surveryPicker2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let db = Firestore.firestore()
    var myPain: String = ""
    var emailinfo : String = ""
    let levels = ["Select Level", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    @IBOutlet weak var pickerLevel: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerLevel.dataSource = self
        pickerLevel.delegate = self
    }
    @IBAction func submitBtn(_ sender: Any) {
        print(emailinfo)
        let docRef = db.collection("Users").document(emailinfo)
        docRef.getDocument{ (document, error) in
                           if let document = document, document.exists {
                               
                               self.performSegue(withIdentifier: "questions", sender: document)
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
        if(segue.identifier == "questions"){
            let destinationVC = segue.destination as! SurveryQuestionsViewController
            destinationVC.email = emailinfo
        
        }
    }

}
