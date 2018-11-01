//
//  CollectionViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: imageSelectionDelegate?
    
    var categories = ["Real Estate Training Events","#TOMSVLOG"]
    var timer : Timer!
    var updateCount : Int!
    
    let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
    let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
    let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var selectedVideoArr : [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCount = 0
        timer = Timer.scheduledTimer(timeInterval: 2.5,target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        getVideo()
    }
    
    @objc internal func updateTimer()
    {
        if(updateCount <= 2){
            pageControll.currentPage = updateCount
            imageView.image = UIImage(named: String(updateCount+1) + ".jpg")
            updateCount = updateCount + 1
        }
        else{
            updateCount = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subClass") as! SubClass
        
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    func getVideo() {
        let urlRequest = URLRequest(url: URL(string: requestUrl)!)
        let urlString = urlRequest.url?.absoluteString
        var arrayOfVideos = [Video]()
        
        Alamofire.request(urlString!, method: .get, parameters: ["maxResults": "25", "part": "snippet", "playlistId": UPLOADS_PLAYIST_ID, "key": API_KEY]).responseJSON {
            response in
            
            if response.result.isSuccess {
                let resJSON : JSON = JSON(response.result.value!)
                let videoData = resJSON["items"]
                
                for video in videoData.arrayValue {
                    let videoObj = Video()
                    videoObj.videoID = video["snippet"]["resourceId"]["videoId"].stringValue
                    videoObj.videoTitle = video["snippet"]["title"].stringValue
                    videoObj.videoDescription = video["snippet"]["description"].stringValue
                    videoObj.videoThumbnailUrl = video["snippet"]["thumbnails"]["high"]["url"].stringValue
                    arrayOfVideos.append(videoObj)
                }
                
            }
            self.selectedVideoArr = arrayOfVideos
            self.tableView.reloadData()
        }
        
    }

    
}


extension CollectionViewController : imageSelectionDelegate {
    func didSelect(viArr: [Video], selectD: Video, index: IndexPath) {
         performSegue(withIdentifier: "gotoDetail", sender: index)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoDetail" ) {
            
            let detailVC = segue.destination as! DetailViewController
            if let indexPath = sender as? IndexPath {
               
                let videoToOpen = selectedVideoArr![indexPath.row]

                detailVC.name = videoToOpen.videoTitle
                //detailVC.selectedDessertImg = videoToOpen.videoThumbnailUrl
            }
        }
    }
    

}

