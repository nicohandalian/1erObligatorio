//
//  SelectedItem.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class SelectedItem {
    var item: Item
    var quantity: Int
    
    
    init(item:Item, quantity:Int) {
        self.item = item
        self.quantity = quantity
    }
    
}
