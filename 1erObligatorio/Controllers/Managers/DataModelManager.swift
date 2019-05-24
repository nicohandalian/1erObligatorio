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
    static let shared = DataModelManager()
    var trolley = Trolley()
    
    
    private init() {
    }
    
    
//    func getBanners()->[Banner] {
//        
//        
//        let bananaBannerImage = UIImage(named: "Banner-1")!
//        let bananaBanner = Banner( picture: bananaBannerImage, title: "Product of the month", description: "Brazilian Bananas")
//        
//        let grapefruitBannerImage = UIImage(named: "Banner-2")!
//        let grapefruitBanner = Banner(picture: grapefruitBannerImage, title: "Best grapefruits ever", description: "From Africa")
//        
//        let cucumberBannerImage = UIImage(named: "Banner-3")!
//        let cucumberBanner = Banner(picture: cucumberBannerImage, title: "Product of the week", description: "100% organic")
//        
//        let kiwiBannerImage = UIImage(named: "Banner-4")!
//        let kiwiBanner = Banner(picture: kiwiBannerImage, title: "Recommended", description: "Directly from NZ")
//        
//        
//        
//        let banners:[Banner] = [bananaBanner, grapefruitBanner, cucumberBanner, kiwiBanner]
//        return banners
//    }
    
    func getTrolley()->Trolley{
        return trolley
    }
    
    func getItemTypes()->[ItemType]{
        return [ItemType.fruit, ItemType.veggie]
    }
    
}
