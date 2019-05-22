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
    var price: Float?
    var smallImage: UIImage?
    var bigImage: UIImage?
    
    var category: String?{
        didSet{
            switch category!.capitalized {
            case "Fruits":
                type = .fruit
                break
            case "Diary":
                type = .diary
                break
            case "Veggie":
                type = .veggie
                break
            default:
                break
            }
        }
    }
    
    
    init(id:Int, name:String, type:ItemType, price: Float, smallImage: UIImage, bigImage:UIImage) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
        self.smallImage = smallImage
        self.bigImage = bigImage
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        category <- map["category"]
        price <- map["price"]
        smallImage <- map["photoUrl"]
        bigImage <- map["photoUrl"]
    }
    
}
