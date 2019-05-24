//
//  APIManager.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/21/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager {
    static let shared = APIManager()
    
    let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net/"
  
    
    func getItems(onCompletionHandler: @escaping(_ result: [Item]?, _ error: Error?) -> Void){
        let itemsUrl = baseUrl+"products"
        Alamofire.request(itemsUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[Item]>) in
            switch response.result {
            case .success:
                onCompletionHandler(response.value, nil)

            case .failure(let error):
                onCompletionHandler(nil, error)
            }

        }
    }
    
    func getBanners(onCompletionHandler: @escaping(_ result: [Banner]?, _ error: Error?) -> Void){
        let bannersUrl = baseUrl+"promoted"
        Alamofire.request(bannersUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[Banner]>) in
            switch response.result {
            case .success:
                onCompletionHandler(response.value, nil)
                
            case .failure(let error):
                onCompletionHandler(nil, error)
            }
            
        }
    }
    
    
    func getTrolleys(onCompletionHandler: @escaping(_ result: [Trolley]?, _ error: Error?) -> Void){
        let trolleysUrl = baseUrl+"purchases"
        //        Alamofire.request(peopleUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[Person]>) in
        //            switch response.result {
        //            case .success:
        //                onCompletionHandler(response.value, nil)
        //
        //            case .failure(let error):
        //                onCompletionHandler(nil, error)
        //            }
        //
        //        }
    }
    
    
    func postCheckout(onCompletionHandler: @escaping(_ result: [Trolley]?, _ error: Error?) -> Void){
        let checkoutUrl = baseUrl+"checkout"
        //        Alamofire.request(peopleUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[Person]>) in
        //            switch response.result {
        //            case .success:
        //                onCompletionHandler(response.value, nil)
        //
        //            case .failure(let error):
        //                onCompletionHandler(nil, error)
        //            }
        //
        //        }
    }
    
}
