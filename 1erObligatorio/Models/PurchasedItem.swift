//
//  PurchasedItem.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import ObjectMapper

class PurchasedItem: Mappable {
    var id: Int?
    var quantity: Int?
    
    init(id: Int, quantity: Int) {
        self.id = id
        self.quantity = quantity
    }
    
    required init?(map: Map) {
        if map.JSON["product_id"] == nil { return nil }
        if map.JSON["quantity"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        id <- map["product_id"]
        quantity <- map["quantity"]
    }
    
}
