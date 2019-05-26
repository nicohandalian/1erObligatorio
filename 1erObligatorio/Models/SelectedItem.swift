//
//  SelectedItem.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import ObjectMapper

class SelectedItem: Mappable {
    
    var item: Item?
    var quantity: Int?
    
    
    init(item:Item, quantity:Int) {
        self.item = item
        self.quantity = quantity
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        item <- map["product"]
        quantity <- map["quantity"]
    }
    
}
