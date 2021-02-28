//
//  PhotoCell.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import UIKit
import Photos

class PhotoCell: UICollectionViewCell {

    var data:Info?{
        didSet{
            manageData()
        }
    }

    let cardImage:LazyImageView = {
        let img = LazyImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
    }()
    
 
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 4
        clipsToBounds = true

        addSubview(cardImage)
        cardImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
 
    }

    
    func manageData(){
        guard let data = data else {return}
        
        if let farm = data.farm,
           let server = data.server,
           let id = data.id,
           let secret = data.secret{
            
            let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            if let url = URL(string:urlString){
                cardImage.loadImage(imageUrl: url)
            }
        }
    }
}
