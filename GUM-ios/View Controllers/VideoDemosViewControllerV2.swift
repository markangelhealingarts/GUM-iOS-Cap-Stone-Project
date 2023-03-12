//
//  VideoDemosViewControllerV2.swift
//  GUM-ios
//
//  Created by Ryan Pheang on 3/10/23.
//

import UIKit
import Firebase

class VideoDemosViewControllerV2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var selectCategoryButtonV2: UIButton!
//    Collection of the dropdown menu buttons: Easy, Moderate, Vigorous
    @IBOutlet var categoryButtonsV2: [UIButton]!
    
//    User's email
    var email: String = ""
    let db = Firestore.firestore()
    
    var videoDescriptionList = [Any]()
    var videoIDList = [Any]()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func selectCategoryAction(_ sender: Any) {
        showButtonVisibility()
    }
    
    @IBAction func categoryButtonAction(_ sender: UIButton){
        showButtonVisibility()
//        print("checking")
//        print(videoDescriptionList)

        switch sender.currentTitle {
        case "Easy":
            selectCategoryButtonV2.setTitle("Easy ▼", for: .normal)

            level(x: "Beginner")
        case "Moderate":
            selectCategoryButtonV2.setTitle("Moderate ▼", for: .normal)

            level(x: "Intermediate")
        default:
            selectCategoryButtonV2.setTitle("Vigorous ▼", for: .normal)

            level(x: "Advance")
        }
    }
    
    func showButtonVisibility(){
        categoryButtonsV2.forEach { button in
            button.isHidden = !button.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    func level(x: String) {
        let docRef = db.collection("Videos").document(x)
        docRef.getDocument{ [self] (document,error) in
            if let document = document, document.exists {
                let tempDescriptionList = document.data()!["video_description"]! as! [Any]
                let tempVideoIDList = document.data()!["youtubeID"] as! [Any]
                videoDescriptionList = tempDescriptionList
                videoIDList = tempVideoIDList
                self.tableView.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDescriptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCellV2") as! VideoCellV2
//        print(count)

        if(count < videoDescriptionList.count){
            cell.labelVideoTitle.text = videoDescriptionList[count] as? String
            cell.ytPlayerView.load(withVideoId: videoIDList[count] as! String)
            count += 1

        }
        
        if(count == videoDescriptionList.count){
            count = 0
        }
        
        return cell
    }
}
