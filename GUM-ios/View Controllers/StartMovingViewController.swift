//
//  StartMovingViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/4/22.
//

import UIKit
import Firebase

class StartMovingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
<<<<<<< HEAD
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var moderateButton: UIButton!
    @IBOutlet weak var vigorousButton: UIButton!
=======
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
    
>>>>>>> origin/sophia
    @IBOutlet weak var intervalButton: UIButton!
    
    var email: String = ""
    var pickerData: [String] = []
    
    var selectedBtn: Int = -1
<<<<<<< HEAD
    var selectedPicker: String = ""
    var selectedInterval: String = ""
    
    var interval: Bool = false
    var selectedType:String = ""
=======
    var selectedPicker: Int = 0
    var selectedInterval: String = ""
    
    var interval: Bool = false
    var difficulty: String = ""
    var selectedType = ""
    
    var info = Info(email: "", selectedPicker: 0, difficulty: "")
    
>>>>>>> origin/sophia
    
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
    
<<<<<<< HEAD
=======
    
>>>>>>> origin/sophia
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
<<<<<<< HEAD
        selectedPicker = pickerData[row]
=======
        selectedPicker = row
>>>>>>> origin/sophia
    }
    
    
    @IBAction func onEasyBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = easyButton.tag
<<<<<<< HEAD
        selectedType = "Beginner"
=======
>>>>>>> origin/sophia
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onModerateBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = moderateButton.tag
<<<<<<< HEAD
        selectedType = "Moderate"
=======
>>>>>>> origin/sophia
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onVigorousBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = vigorousButton.tag
<<<<<<< HEAD
        selectedType = "Advance"
=======
>>>>>>> origin/sophia
        highlightBtn()
        
        showPicker()
    }
    
    @IBAction func onIntervalBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        
        selectedBtn = intervalButton.tag
<<<<<<< HEAD
        selectedType = "Interval"
=======
>>>>>>> origin/sophia
        highlightBtn()
        
        // make a drop down for different times on press
        showPicker()
    }
    
<<<<<<< HEAD
    
    
    @IBAction func startBtn(_ sender: Any) {
        
        if selectedType == "Interval" && selectedInterval == ""{
            showAlert(name: "Error", message: "Please choose interval time")
        } else if selectedType == ""{
            showAlert(name: "Error", message: "Please choose a difficulty level")
        } else if selectedPicker == "" {
            showAlert(name: "Error", message: "Please choose a video")
        } else {
            performSegue(withIdentifier: "startToVideo", sender: nil)
        }
    }
    
=======
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
    
    
    
>>>>>>> origin/sophia
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "startToVideo"){
            let destinationVC = segue.destination as! ExerciseVideoViewController
<<<<<<< HEAD
            destinationVC.email = email
            destinationVC.selectedPicker = selectedPicker
            destinationVC.difficulty = selectedType
=======
            destinationVC.email = info.email
            destinationVC.selectedPicker = info.selectedPicker
            destinationVC.difficulty = info.difficulty
>>>>>>> origin/sophia
        }
    }
    
    func highlightBtn () {
        
        easyButton.tintColor = UIColor.blue
        moderateButton.tintColor = UIColor.blue
        vigorousButton.tintColor = UIColor.blue
        intervalButton.tintColor = UIColor.blue
        
        if easyButton.tag == selectedBtn {
            self.easyButton.tintColor = UIColor.green
<<<<<<< HEAD
            selectedType = "Beginner"
=======
            
            difficulty = "easy"
>>>>>>> origin/sophia
            interval = false
            
        } else if moderateButton.tag == selectedBtn {
            self.moderateButton.tintColor = UIColor.yellow
            
<<<<<<< HEAD
            selectedType = "Moderate"
=======
            difficulty = "moderate"
>>>>>>> origin/sophia
            interval = false
            
        } else if vigorousButton.tag == selectedBtn {
            self.vigorousButton.tintColor = UIColor.red
<<<<<<< HEAD
            selectedType = "Advance"
=======
            
            difficulty = "hard"
>>>>>>> origin/sophia
            interval = false
            
        } else {
            self.intervalButton.tintColor = UIColor.black
<<<<<<< HEAD
            selectedType = "Interval"
=======
            
            difficulty = "interval"
>>>>>>> origin/sophia
            interval = true
        }
        
    }
    
    func showPicker () {
        
<<<<<<< HEAD
        let docRef = db.collection("StartMoving").document(selectedType)
        
        print(selectedType)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                let videos = data!["Titles"] as! NSArray
                
                self.pickerData = []
                self.pickerData += videos as! [String]
                self.selectedPicker = self.pickerData[0]
=======
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
>>>>>>> origin/sophia
                self.pickerView.reloadAllComponents()

            } else {
                print("Error: \(String(describing: error))")
            }
        }
        
        
        pickerView.layer.opacity = 1
    }

}
