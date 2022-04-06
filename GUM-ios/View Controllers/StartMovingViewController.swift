//
//  StartMovingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/4/22.
//

import UIKit
import Firebase

class StartMovingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    struct Info {
        var email: String = ""
        var selectedPicker: Int = -1
        var difficulty: String = ""
        
        init(email: String, selectedPicker: Int, difficulty: String){
            self.email = email
            self.selectedPicker = selectedPicker
            self.difficulty = difficulty
        }
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var moderateButton: UIButton!
    
    @IBOutlet weak var vigorousButton: UIButton!
    
    @IBOutlet weak var intervalButton: UIButton!
    
    var email: String = ""
    var pickerData: [String] = []
    
    var selectedBtn: Int = -1
    var selectedPicker: Int = 0
    var selectedInterval: String = ""
    
    var interval: Bool = false
    var difficulty: String = ""
    var selectedType = ""
    
    var info = Info(email: "", selectedPicker: 0, difficulty: "")
    
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerView.layer.opacity = 0
        
        self.easyButton.backgroundColor = UIColor.blue
        self.moderateButton.backgroundColor = UIColor.blue
        self.vigorousButton.backgroundColor = UIColor.blue
        self.intervalButton.backgroundColor = UIColor.blue
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPicker = row
    }
    
    
    @IBAction func onEasyBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = easyButton.tag
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onModerateBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = moderateButton.tag
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onVigorousBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = vigorousButton.tag
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onIntervalBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = intervalButton.tag
        highlightBtn()
        
        // make a drop down for different times on press
        showPicker()
    }
    
    @IBAction func onStartBtn(_ sender: Any) {
        
        if difficulty == "interval" && selectedInterval == ""{
            showAlert(name: "Error", message: "Please choose interval time")
        } else if difficulty == ""{
            showAlert(name: "Error", message: "Please choose a difficulty level")
        } else if selectedPicker == -1 {
            showAlert(name: "Error", message: "Please choose a video")
        } else {
            info = Info(email: email, selectedPicker: selectedPicker, difficulty: selectedType)
            self.performSegue(withIdentifier: "startToVideo", sender: info)
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "startToVideo"){
            let destinationVC = segue.destination as! ExerciseVideoViewController
            destinationVC.email = info.email
            destinationVC.selectedPicker = info.selectedPicker
            destinationVC.difficulty = info.difficulty
        }
    }
    
    func highlightBtn () {
        
        easyButton.tintColor = UIColor.blue
        moderateButton.tintColor = UIColor.blue
        vigorousButton.tintColor = UIColor.blue
        intervalButton.tintColor = UIColor.blue
        
        if easyButton.tag == selectedBtn {
            self.easyButton.tintColor = UIColor.green
            
            difficulty = "easy"
            interval = false
            
        } else if moderateButton.tag == selectedBtn {
            self.moderateButton.tintColor = UIColor.yellow
            
            difficulty = "moderate"
            interval = false
            
        } else if vigorousButton.tag == selectedBtn {
            self.vigorousButton.tintColor = UIColor.red
            
            difficulty = "hard"
            interval = false
            
        } else {
            self.intervalButton.tintColor = UIColor.black
            
            difficulty = "interval"
            interval = true
        }
        
    }
    
    func showPicker () {
        
        if selectedBtn == 0 {
            selectedType = "Beginner"
        } else if selectedBtn == 1 {
            selectedType = "Intermediate"
        } else {
            selectedType = "Advance"
        }
        
        let docRef = db.collection("Videos").document(selectedType)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() //access the data
                let video_description = data?["video_description"] as! NSArray
                
                self.pickerData = []
                
                self.pickerData += video_description as! [String]
                self.pickerView.reloadAllComponents()

            } else {
                print("Error: \(String(describing: error))")
            }
        }
        
        
        pickerView.layer.opacity = 1
    }

}
