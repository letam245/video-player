//
//  ViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/25/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var videos : [Video] = [Video]()
    var selectedVideo : Video?
    
    let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
    let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
    let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //videos = VideoHelper.getFeedVideos()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getFeedVideos()
        
    }
    
    
    func getFeedVideos() {
        let urlRequest = URLRequest(url: URL(string: requestUrl)!)
        let urlString = urlRequest.url?.absoluteString
        var arrayOfVideos = [Video]()
        
        Alamofire.request(urlString!, method: .get, parameters: ["maxResults": "25", "part": "snippet", "playlistId": UPLOADS_PLAYIST_ID, "key": API_KEY]).responseJSON {
            response in
            
            if response.result.isSuccess {
                let resJSON : JSON = JSON(response.result.value!)
                let videoData = resJSON["items"]
                
                for video in videoData.arrayValue {
                    print(video)
                    let videoObj = Video()
                    videoObj.videoID = video["snippet"]["resourceId"]["videoId"].stringValue
                    videoObj.videoTitle = video["snippet"]["title"].stringValue
                    videoObj.videoDescription = video["snippet"]["description"].stringValue
                    videoObj.videoThumbnailUrl = video["snippet"]["thumbnails"]["high"]["url"].stringValue
                    arrayOfVideos.append(videoObj)
                }
                
            }
            self.videos = arrayOfVideos
            self.tableView.reloadData()
        }
    }
    

    
    //MARK: - VideoModelDelegate Method
    func dataReady() {
       
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

