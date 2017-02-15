//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Octavio Cedeno on 2/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class GIF {
    
    let url: URL
    let videoURL: NSURL
    var caption: String?
    var gifImage: UIImage?
    var gifData: NSData?
    
    init(url: URL, videoURL: NSURL, caption: String?) {
        
        self.url = url
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)
        self.gifData = nil
    }
    
    func initWithName(name: String){
        gifImage = UIImage.gif(name: name)
    }
}
