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
    
    //var videos : [Video] = [Video]()
    var videos = VideoArrayModel().videos
    var selectedVideoID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let model = VideoModel()
        //self.videos = model.getVideos()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (self.view.frame.width / 640) * 360
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!

        
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(id: videos[indexPath.row].videoID, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
           
            
            DispatchQueue.main.async() {
                
                //cell.textLabel?.text = vid.title
                
                let label = cell.viewWithTag(2) as! UILabel
                
                label.text = vid.title
                
                //label.lineBreakMode = .byWordWrapping
                //label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
                
                if let url = vid.thumbnailURL[.Quality640] {
                    self.getDataFromUrl(url: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let imageView = cell.viewWithTag(1) as! UIImageView
                            imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        })
        
        
        
        /*
        //let videoTitle = videos[indexPath.row].videoTitle
        
        //Customize cell to display video title
        //cell.textLabel?.text = videoTitle
        
        
        //Construct the video thumnail url
        let videoThumbnailUrLString = "http://img.youtube.com/vi/" + videos[indexPath.row].videoID + "/mqdefault.jpg"
        
        
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
                    imageView.image = UIImage(data: data!)
                }
                
            }
            
            dataTask.resume()
            
            
        }
        */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoID = videos[indexPath.row].videoID
        
         self.performSegue(withIdentifier: "goToDeltailVideo", sender: self)
       
        
    }
    
    /*
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    */
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detaiVC = segue.destination as! VideoDetailViewController
        
        detaiVC.selectedVideoId = self.selectedVideoID
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(id: selectedVideoID!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let selectedVideo = video else {
                print("Invalid video object")
                return
            }
        
            
           
            detaiVC.selectedVideo = selectedVideo
            
            
        })
        

    }
    


}

