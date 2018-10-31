//
//  VideoHelper.swift
//  video-player
//
//  Created by Tammy Le on 10/31/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//protocol VideoModelDelegate {
//    func dataReady()
//}

struct VideoHelper {
    let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
    let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
    let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    var videoArray = [Video]()
    
    static func getFeedVideos() {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
         
        }
        /*
        Alamofire.request(requestUrl, method: .get, parameters: ["maxResults": "25", "part": "snippet", "playlistId": UPLOADS_PLAYIST_ID, "key": API_KEY]).responseJSON {
            response in
            if response.result.isSuccess {
                let resJSON : JSON = JSON(response.result.value!)
                
                var arrayOfVideos = [Video]()
                
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
                self.videoArray = arrayOfVideos
                
                if self.delegate != nil {
                    self.delegate!.dataReady()
                }
            }
            
        }
    }
 */
    }
}
