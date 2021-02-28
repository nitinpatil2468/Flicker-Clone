//
//  NetworkRequestHandler.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import Foundation
import Alamofire

class NetworkRequestHandler{
    static let shared = NetworkRequestHandler()

    
    
    //get method
    func GET(url:URL,completion:@escaping(String?,Error?)->Void){

        let headers:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        AF.request(url, method: .get, encoding: URLEncoding.httpBody,headers: headers)
            .responseString (completionHandler: {
                response in
                switch response.result {

                case .failure(let error):
                    print(error)
                    completion(nil,error)

                case .success(let value):

                    completion(value as! String,nil)
                }
            })
    }
    

    
}
        
        

    

