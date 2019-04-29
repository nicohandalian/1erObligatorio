//
//  Fruit.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class Item {
    var id: Int
    var name: String
    var type: ItemType
    var price: Float
    var smallImage: UIImage
    var bigImage: UIImage
    
    
    init(id:Int, name:String, type:ItemType, price: Float, smallImage: UIImage, bigImage:UIImage) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
        self.smallImage = smallImage
        self.bigImage = bigImage
    }
    
}
