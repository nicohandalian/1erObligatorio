//
//  Banner.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Banner:Mappable {
    var imageUrl: URL?
    var title: String?
    var description: String?
    var stringUrl: String?{
        didSet{
            guard let stringUrl = stringUrl else{
                imageUrl = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUq7tDg_fFFVBh2y25hj1VQ--gJ1v1idoOwwh8Bu9dfbj9R7Mow")
                return
            }
            imageUrl = URL(string: stringUrl)
        }
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["name"]
        description <- map["description"]
        stringUrl <- map["photoUrl"]
    }
    
    
    
    
}
