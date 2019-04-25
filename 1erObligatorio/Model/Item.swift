//
//  Fruit.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class Item {
    var id: Int
    var name: String
    var type: ItemType
    var price: Float
    
    
    init(id:Int, name:String, type:ItemType, price: Float) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
    }
    
}
