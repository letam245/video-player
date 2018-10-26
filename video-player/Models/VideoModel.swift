//
//  VideoModel.swift
//  video-player
//
//  Created by Tammy Le on 10/25/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
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
}
