//
//  ExerciseVideoViewController.swift
//  GUM-ios
//
//  Created by Tim Johnson on 3/21/22.
//

import UIKit
import Firebase
import WebKit

class ExerciseVideoViewController: UIViewController, WKUIDelegate{
    
    
    @IBOutlet var videoWebView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var email: String = ""
    var selectedPicker: Int = -1 // this gives the row so we can get correct video
    var difficulty: String = ""
    var selectedVideo: String = ""
    
    let db = Firestore.firestore()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        videoWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        videoWebView.uiDelegate = self
        view = videoWebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let docRef = db.collection("Videos").document(difficulty)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() //access the data
                let video = data?["videos_list"] as! NSArray
                
                self.selectedVideo = video[self.selectedPicker] as! String
//                videoWebView = self.selectedVideo
                // change database to hold just youtube link not with iFrame for iOS
                //
                let myURL = URL(string:"https://www.youtube.com/embed/LIioNcZee30")
                let myRequest = URLRequest(url: myURL!)
                self.videoWebView.load(myRequest)

            } else {
                print("Error: \(String(describing: error))")
            }
        }
        // Do any additional setup after loading the view.
    }

}
