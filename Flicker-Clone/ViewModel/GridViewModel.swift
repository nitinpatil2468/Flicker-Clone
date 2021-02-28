//
//  GridViewModel.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import Foundation

class GridViewModel {
    
    var photoArray = [Info]()
    weak var vc : ViewController?
    
    var page = Int()
    
    func getAllPhotos(){
        
        let APIRequest = "\(Constant.BASE_PATH)&api_key=\(Constant.APIKey)&per_page=10&format=json&page=\(page)"
        let url = URL(string: APIRequest)
        
        
        NetworkRequestHandler.shared.GET(url:url!, completion: {(responseString , error) in
            if let xmlString = responseString{
                print("xmlString -> \(xmlString)")
                var final = String()
                final = String(xmlString.dropLast())
                final = String(final.dropFirst(14))
                print(final)
                do {
                    let jsonData = final.data(using: .utf8)
                    
                    if let userInfo = try JSONDecoder().decode(ResponseData.self, from: jsonData!) as? ResponseData{
                        
                        if let data = userInfo.photos?.photo{
                            self.photoArray.append(contentsOf: data)
                            DispatchQueue.main.async {
                                self.vc?.collectionView.reloadData()
                            }
                        }else{
                            self.vc?.popupAlert(title: "Alert", message:"Something went wrong", actionTitles: ["Reload"], actions: [{UIAlertAction in self.getAllPhotos()}])
                        }
                        
                    }
             
                } catch {
                    
                    print(error.localizedDescription)
                    
                }
            }else if let error = error{
                print (error.localizedDescription as Any);
                self.vc?.popupAlert(title: "Alert", message:error.localizedDescription, actionTitles: ["Reload"], actions: [{UIAlertAction in self.getAllPhotos()}])

            }
        })
    }
}
