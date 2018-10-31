//
//  ViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/25/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
import HCVimeoVideoExtractor

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var videos : [Video] = [Video]()
    var selectedVideo : Video?
    
    let model : VideoModel = VideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.model.delegate = self
        //self.videos = model.getVideos()
        model.getFeedVideos()
        //model.getPlaylistVideo()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
    }
    
    //MARK: - VideoModelDelegate Method
    func dataReady() {
        self.videos = self.model.videoArray
        self.tableView.reloadData()

    }
    
    // MARK: - TableView Delegate method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (self.view.frame.width / 480) * 360
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        
        let videoTitle = videos[indexPath.row].videoTitle
        
        //Customize cell to display video title
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videoTitle
        
        
        //Construct the video thumnail url
        let videoThumbnailUrLString = videos[indexPath.row].videoThumbnailUrl
        
        
        //Create an NSURL object
        let videoThumbnailUrl = NSURL(string: videoThumbnailUrLString)
        
        if videoThumbnailUrl != nil {
            //Create an NSURLRequest object
            let request = URLRequest(url: videoThumbnailUrl! as URL)
            
            //Create an NSURLSession
            let session = URLSession.shared
            
            //Create a datatask and pass in the request
            let dataTask = session.dataTask(with: request) { (data: Data?, response:URLResponse?, error: Error?) in
                
                DispatchQueue.main.async() {
                    // Get a reference to the imageView element of teh cell
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    //Create an image object from the data and asisgn it into the imageview
                    if data != nil {
                         imageView.image = UIImage(data: data!)
                    }
                   
                }
                
            }
            
            dataTask.resume()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedVideo = videos[indexPath.row]
        
        self.performSegue(withIdentifier: "goToDeltailVideo", sender: self)
       
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detaiVC = segue.destination as! VideoDetailViewController
        
        detaiVC.selectedVideo = self.selectedVideo
        
    }
    


}

