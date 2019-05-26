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
        let itemsUrl = baseUrl + "products"
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
        let bannersUrl = baseUrl + "promoted"
        Alamofire.request(bannersUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[Banner]>) in
            switch response.result {
            case .success:
                onCompletionHandler(response.value, nil)
                
            case .failure(let error):
                onCompletionHandler(nil, error)
            }
            
        }
    }
    
    
    func getPurchases(onCompletionHandler: @escaping(_ result: [Trolley]?, _ error: Error?) -> Void){
        let purchasesUrl = baseUrl + "purchases"
        AuthenticationManager.shared.authenticate { (authenticationResponse) in
            let bearer = "Bearer " + authenticationResponse.token
            let headers: HTTPHeaders = ["Authorization" : bearer]
            
            Alamofire.request(purchasesUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseArray { (response: DataResponse<[Trolley]>) in
                switch response.result {
                case .success:
                    onCompletionHandler(response.value, nil)
                    
                case .failure(let error):
                    onCompletionHandler(nil, error)
                }
                
            }
            
        }
    }
    
    
    func postCheckout(json: Any, onCompletion: @escaping (String?, Error?) -> Void) {
        let checkoutUrl = baseUrl + "checkout"
        
        AuthenticationManager.shared.authenticate { (authenticationResponse) in
            let bearer = "Bearer " + authenticationResponse.token
            let headers: HTTPHeaders = ["Authorization" : bearer, "content-type":"application/json"]
            let parameters: [String:Any] = ["cart": json]
            
            Alamofire.request(checkoutUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseString(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onCompletion(response.result.value, nil)
                case .failure(let error):
                    onCompletion(nil, error)
                }
            })
        }
    }
    
}
