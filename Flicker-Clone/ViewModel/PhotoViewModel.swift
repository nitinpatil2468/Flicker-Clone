//
//  PhotoViewModel.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import Foundation

class PhotoViewModel {
    
    var photoInfo:Info?{
        didSet{
            getPhoto()
        }
    }

    weak var vc : PhotoContoller?
    
    func getPhoto(){
        
        if let farm = photoInfo?.farm,
           let server = photoInfo?.server,
           let id = photoInfo?.id,
           let secret = photoInfo?.secret{
            
            let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            if let url = URL(string:urlString){
                print("photoURL :\(url)")
                vc?.cardImage.loadImage(imageUrl: url)
            }
        }
}
}

