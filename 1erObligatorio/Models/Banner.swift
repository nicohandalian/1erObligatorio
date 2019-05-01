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
    var picture: UIImage
    var title: String
    var description: String
    
    
    init(picture:UIImage, title:String,description: String) {
        self.picture = picture
        self.title = title
        self.description = description
    }
    
}
