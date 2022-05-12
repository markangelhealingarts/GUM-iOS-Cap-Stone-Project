//
//  VideoCell.swift
//  GUM-ios
//
//  Created by Jennifer Lopez on 5/11/22.
//

import Foundation
import UIKit
import YouTubePlayer
class VideoCell: UITableViewCell{
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var DemoYoutubeVideo: YouTubePlayerView!
    @IBOutlet weak var demoVideo: UIView!
    @IBOutlet weak var videoDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
