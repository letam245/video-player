//
//  VideoHelper.swift
//  video-player
//
//  Created by Tammy Le on 10/31/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

struct VideoHelper {
    static func getVideo() {
        let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
        let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
        let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
        
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
        }
        
    }

}
