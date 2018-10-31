//
//  VideoDetailViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/26/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

    var selectedVideo : Video?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var descriptionTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if selectedVideo != nil {
            titleLabel.text = selectedVideo!.videoTitle
            titleLabel.frame = CGRect(x:0,y:0,width:titleLabel.intrinsicContentSize.width,height:titleLabel.intrinsicContentSize.width)
            descriptionTxt.text = selectedVideo?.videoDescription
            

        
            let width = CGFloat(self.view.frame.size.width)
            let height = CGFloat(width/480) * 360
            
            
            let widthString = "\(width)"
            let heightString = "\(height)"
            let selectedVideoIdStr = "\(selectedVideo!.videoID)"
            
            webViewHeightConstrain.constant = height
            webView.allowsInlineMediaPlayback = true
            

            
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen height=\"" + heightString + "\" width=\"" + widthString + "\" src=\"https://www.youtube.com/embed/" + selectedVideoIdStr + "?playsinline=1\"></iframe></body></html>"
         
            self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
        }
    }
    
}
