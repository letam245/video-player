//
//  VideoDetailViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/26/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
//import HCVimeoVideoExtractor

class VideoDetailViewController: UIViewController {

    //var selectedVideo : HCVimeoVideo?
    var selectedVideo : Video?
    //var selectedVideoId : String?
    

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webViewHeightConstrain: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if selectedVideo != nil {
            titleLabel.text = selectedVideo!.videoTitle
            descriptionLabel.text = selectedVideo?.videoDescription
        
            let width = CGFloat(self.view.frame.size.width)
            let height = CGFloat(width/320 * 180)
            
            
            let widthString = "\(width)"
            let heightString = "\(height)"
            let selectedVideoIdStr = "\(selectedVideo!.videoID)"
            
            webViewHeightConstrain.constant = height
            webView.allowsInlineMediaPlayback = true
            
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen height=\"" + heightString + "\" width=\"" + widthString + "\" src=\"https://www.youtube.com/embed/" + selectedVideoIdStr + "?playsinline=1\"></iframe></body></html>"
            
            //let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + heightString + "\" width=\"" + widthString + "\" src=\"https://player.vimeo.com/video/" + selectedVideo.videoID + "?autoplay=1 allowFullScreen\"></iframe></body></html>"
            
            self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
            
            
            //<iframe width="560" height="315" src="https://www.youtube.com/embed/z8pbEHa2agk" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
