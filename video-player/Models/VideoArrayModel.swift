//
//  VideoArray.swift
//  video-player
//
//  Created by Tammy Le on 10/26/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

class VideoArrayModel {
   
        var videos = [VideoArray]()
    
        //Vimeo
        init() {
            videos.append(VideoArray(id: "203165890"))
            videos.append(VideoArray(id: "286570272"))
            videos.append(VideoArray(id: "288253576"))
            videos.append(VideoArray(id: "280633411"))
            videos.append(VideoArray(id: "164343116"))
        }
}
