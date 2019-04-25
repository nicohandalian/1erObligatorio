//
//  Banner.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class Banner {
    var item: Item
    var picture: String
    var description: String
    
    
    init(item:Item, picture:String, description: String) {
        self.item = item
        self.picture = picture
        self.description = description
    }
    
}
