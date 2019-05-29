//
//  Fruit.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Item: Mappable {
    var id: Int?
    var name: String?
    var type: ItemType?
    var price: Float?{
        didSet{
            price = (price! * 100).rounded() / 100
        }
    }
    var imageUrl: URL?
    var stringUrl: String?{
        didSet{
            guard let stringUrl = stringUrl else{
                imageUrl = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUq7tDg_fFFVBh2y25hj1VQ--gJ1v1idoOwwh8Bu9dfbj9R7Mow")
                return
            }
            imageUrl = URL(string: stringUrl)
        }
    }
    
    var category: String?{
        didSet{
            switch category!.capitalized {
            case "Fruits":
                type = .fruit
                break
            case "Dairy":
                type = .diary
                break
            case "Veggies":
                type = .veggie
                break
            default:
                type = .other
                break
            }
        }
    }
    
    required init?(map: Map) {
        if map.JSON["id"] == nil { return nil }
        if map.JSON["name"] == nil { return nil }
        if map.JSON["price"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        category <- map["category"]
        price <- map["price"]
        stringUrl <- map["photoUrl"]
    }
}
