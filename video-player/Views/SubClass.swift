//
//  SubClass.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol imageSelectionDelegate {
    func didSelect(viArr: [Video], selectD: Video, index: IndexPath)
}

class SubClass: UITableViewCell {
    
    
    let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
    let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
    let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var delegate: imageSelectionDelegate?
    
    var selectedVideo : Video?
    var videos : [Video] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
   
        getVideo()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
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
            self.videos = arrayOfVideos
            self.collectionView.reloadData()
        }
        
    }

}

extension SubClass: UICollectionViewDataSource,UICollectionViewDelegate {
    //MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoViewCell
        
        myCell.myVideo = videos[indexPath.row]
        
        return myCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedVideo = videos[indexPath.row]
        delegate?.didSelect(viArr: videos, selectD: selectedVideo!, index: indexPath)

    }

}

