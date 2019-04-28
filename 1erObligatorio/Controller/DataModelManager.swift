//
//  DataModelManager.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class DataModelManager {
    static let dataModelManager = DataModelManager()
    
    private init() {
        
    }
    static func getItems()->[Item] {
        
        let grapefruitSmallImage = UIImage(named: "Grapefruit")!
        let grapefruitBigImage = UIImage(named: "Grapefruit-2")!
        let grapefruit = Item(id: 1, name: "Grapefuit", type: ItemType.fruit, price: 30, smallImage: grapefruitSmallImage, bigImage: grapefruitBigImage)
        
        let products:[Item] = [grapefruit]
        return products
    }
    
    static func getBanners()->[Banner] {
        
        let items = DataModelManager.getItems()
        let grapegruitBannerImage = UIImage(named: "Banner-2")!
        let grapefruitBanner = Banner(item: items[0], picture: grapegruitBannerImage, title: "Best grapefruits ever", description: "From Africa")
        let banners:[Banner] = [grapefruitBanner]
        return banners
    }
    
}
