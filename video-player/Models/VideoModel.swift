//
//  VideoModel.swift
//  video-player
//
//  Created by Tammy Le on 10/25/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyBJS1VQmAfI5Y7sh21mosJEUdLt6l_-Pzg"
    let UPLOADS_PLAYIST_ID = "PLlnz4BpiHqRHoiM_yrUY0buI47qGzhkGX"
    let requestUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    var videoArray = [Video]()
    
    var delegate:VideoModelDelegate?
    
    func getFeedVideos() {
        Alamofire.request(requestUrl, method: .get, parameters: ["maxResults": "12", "part": "snippet", "playlistId": UPLOADS_PLAYIST_ID, "key": API_KEY]).responseJSON {
            response in
            if response.result.isSuccess {
                let resJSON : JSON = JSON(response.result.value!)
                //print ("resJSON : \(resJSON["items"][0])")
                 //print ("resJSON : \(resJSON["items"])")
                
                var arrayOfVideos = [Video]()
                
                let videoData = resJSON["items"]
                
                for video in videoData.arrayValue {
                    print(video)
                    let videoObj = Video()
                    videoObj.videoID = video["snippet"]["resourceId"]["videoId"].stringValue
                    videoObj.videoTitle = video["snippet"]["title"].stringValue
                    videoObj.videoDescription = video["snippet"]["description"].stringValue
                    videoObj.videoThumbnailUrl = video["snippet"]["thumbnails"]["maxres"]["url"].stringValue
                   
                    
                    arrayOfVideos.append(videoObj)
                }
                self.videoArray = arrayOfVideos
                
                if self.delegate != nil {
                    self.delegate!.dataReady()
                }
            }
            
        }
    }
    
    
    /*
    func getVideos() -> [Video] {
        
        //Create an empty array of video objects
        var videos = [Video]()
        

        // YOUTUBE
        let video1 = Video()
        video1.videoID = "DtaBa6G5a_E"
        video1.videoTitle = "How To Make an App - Ep 1 - Tools and Materials"
        video1.videoDescription = "This lesson is an orientation of what you need to start making apps  and the tools and resources that Apple provides."
        //append to the video array
        videos.append(video1)
        
        
        let video2 = Video()
        //Assign properties
        video2.videoID = "dVROCK8BGRY"
        video2.videoTitle = "How To Make an App - Ep 2 - Xcode 6 and Playgrounds"
        video2.videoDescription = "This lesson will help you get your feet wet with Xcode 6 and experimenting with some basic Swift code. Follow along and if you've never programmed before, you'll see that it's not hard!"
        //append to the video array
        videos.append(video2)
        
        

        let video3 = Video()
        //Assign properties
        video3.videoID = "G44oIktEvg8"
        video3.videoTitle = "How To Make an App - Ep 3 - Xcode 6 Tutorial"
        video3.videoDescription = "In this lesson, we walk through the main components and areas of Xcode 6. Take a tour of the app where you'll spend most of your time in!"
        //append to the video array
        videos.append(video3)
        
        
        
        let video4 = Video()
        //Assign properties
        video4.videoID = "ibc1nim--Rc"
        video4.videoTitle = "How To Make an App - Ep 4 - App Anatomy"
        video4.videoDescription = "This video series uses the latest and greatest from Apple (Xcode 6, Swift, iOS 8) and will teach a beginner with no programming experience how to make iPhone apps. I'm creating these videos with the assumption that the student has no prior knowledge and is starting from scratch."
        //append to the video array
        videos.append(video4)
        
        
        
        return videos
    }
     */
}
