//
//  VideoDemosViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/4/22.
//

import UIKit
//import youtube_ios_player_helper_swift
import Firebase
//import YouTubePlayer
//import youtube_ios_player_helper
class VideoDemosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var email: String = ""
    var videoDescription = [Any]()
    var videosList = [Any]()
    var count = 0
    let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet var youtubePlayer: YTPlayerView!  

    @IBOutlet var selectCategoryButton: UIButton!
    @IBOutlet var categoryButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDescription.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        print(count)

        if(count < videoDescription.count){
            cell.videoDescription.text = videoDescription[count] as? String
            cell.webView.loadHTMLString(videosList[count] as! String, baseURL: nil)
            count += 1

        }
        if(count == videoDescription.count){
            count = 0
        }
        return cell
    }


    func showButtonVisibility(){
        categoryButtons.forEach { button in
            button.isHidden = !button.isHidden
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func selectCategoryAction(_ sender: Any) {
        showButtonVisibility()
    }

    func level(x: String) {
        let docRef = db.collection("Videos").document(x)
        docRef.getDocument{ [self] (document,error) in
            if let document = document, document.exists {
//                let data = document.data().map(String.init(describing:)) ?? "nil"
                let data = document.data()!["video_description"]! as! [Any]
                let video = document.data()!["videos_list"]! as! [Any]
                videoDescription = data
                videosList = video
                print("hhhhh")
                print(videoDescription)
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func categoryButtonAction(_ sender: UIButton){
        showButtonVisibility()
        print("checking")
        print(videoDescription)

        switch sender.currentTitle {
        case "Easy":
            selectCategoryButton.setTitle("Easy ▼", for: .normal)

            level(x: "Beginner")
        case "Moderate":
            selectCategoryButton.setTitle("Moderate ▼", for: .normal)

            level(x: "Intermediate")
        default:
            selectCategoryButton.setTitle("Vigorous ▼", for: .normal)

            level(x: "Advance")
        }
    }
}
