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
    @IBOutlet weak var navBarButtonStart: UIBarButtonItem!
    
    var email: String = ""
    var pickerData: [String] = []

    var selectedBtn: Int = -1

    var selectedPicker: String = ""
    var selectedInterval: String = ""

    var interval: Bool = false
    var selectedType:String = ""

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
        selectedPicker = pickerData[row]
    }


    @IBAction func onEasyBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        self.navigationItem.rightBarButtonItem?.isEnabled = true

        selectedBtn = easyButton.tag
        selectedType = "Beginner"
        highlightBtn()

        showPicker()
    }

    @IBAction func onModerateBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        self.navigationItem.rightBarButtonItem?.isEnabled = true

        selectedBtn = moderateButton.tag
        selectedType = "Moderate"
        highlightBtn()

        showPicker()
    }

    @IBAction func onVigorousBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        self.navigationItem.rightBarButtonItem?.isEnabled = true

        selectedBtn = vigorousButton.tag
        selectedType = "Advance"
        highlightBtn()

        showPicker()
    }

    @IBAction func onIntervalBtn(_ sender: Any) {
        // highlight button and save which button has been pressed
        self.navigationItem.rightBarButtonItem?.isEnabled = true

        selectedBtn = intervalButton.tag
        selectedType = "Interval"
        highlightBtn()

        // make a drop down for different times on press
        showPicker()
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "startToVideo"){
            let destinationVC = segue.destination as! ExerciseVideoViewController
            destinationVC.email = email
            destinationVC.selectedPicker = selectedPicker
            destinationVC.difficulty = selectedType
        }
    }

    func highlightBtn () {

        easyButton.tintColor = UIColor.blue
        moderateButton.tintColor = UIColor.blue
        vigorousButton.tintColor = UIColor.blue
        intervalButton.tintColor = UIColor.blue

        if easyButton.tag == selectedBtn {
            self.easyButton.tintColor = UIColor.green
            selectedType = "Beginner"
            interval = false

        } else if moderateButton.tag == selectedBtn {
            self.moderateButton.tintColor = UIColor.yellow
            selectedType = "Moderate"
            interval = false

        } else if vigorousButton.tag == selectedBtn {
            self.vigorousButton.tintColor = UIColor.red
            selectedType = "Advance"
            interval = false

        } else {
            self.intervalButton.tintColor = UIColor.black
            selectedType = "Interval"
            interval = true
        }

    }

    func showPicker () {
        let docRef = db.collection("StartMoving").document(selectedType)

        print(selectedType)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()

                let videos = data!["Titles"] as! NSArray

                self.pickerData = []
                self.pickerData += videos as! [String]
                self.selectedPicker = self.pickerData[0]

                self.pickerView.reloadAllComponents()

            } else {
                print("Error: \(String(describing: error))")
            }
        }


        pickerView.layer.opacity = 1
    }

}
