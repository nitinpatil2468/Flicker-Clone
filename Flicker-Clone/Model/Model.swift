//
//  Model.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import Foundation

struct ResponseData : Codable{
    let photos : PhotosInfo?
    let stat :String?
}

struct PhotosInfo : Codable{
    let page : Int?
    let photo : [Info]?
}

struct Info : Codable{
    let id : String?
    let secret : String?
    let server : String?
    let farm : Int?
}

