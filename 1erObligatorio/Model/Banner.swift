//
//  Banner.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class Banner {
    var item: Item
    var picture: UIImage
    var title: String
    var description: String
    
    
    init(item:Item, picture:UIImage, title:String,description: String) {
        self.item = item
        self.picture = picture
        self.title = title
        self.description = description
    }
    
}
