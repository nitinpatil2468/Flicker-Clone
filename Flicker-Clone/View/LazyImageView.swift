//
//  LazyImageView.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import Foundation
import UIKit
import Kingfisher

class LazyImageView : UIImageView{
    
    let imageCache = NSCache<AnyObject,UIImage>()
    func loadImage(imageUrl : URL){
        

        self.kf.indicatorType = .activity
        let imgResource = ImageResource(downloadURL: imageUrl, cacheKey: imageUrl.absoluteString)
        self.kf.setImage(with: imgResource, placeholder: nil, options: [.transition(.fade(0.7))], completionHandler: nil)
        
    }
}

