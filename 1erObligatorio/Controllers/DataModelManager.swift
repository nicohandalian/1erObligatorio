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
    let trolley = Trolley()
    
    private init() {
    }
    
    func getItems()->[[Item]] {
        
        let grapefruitSmallImage = UIImage(named: "Grapefruit")!
        let grapefruitBigImage = UIImage(named: "Grapefruit-2")!
        let grapefruit = Item(id: 1, name: "Grapefuit", type: ItemType.fruit, price: 45, smallImage: grapefruitSmallImage, bigImage: grapefruitBigImage)
        
        let avocadoSmallImage = UIImage(named: "Avocado")!
        let avocadoBigImage = UIImage(named: "Avocado")!
        let avocado = Item(id: 2, name: "Avocado", type: ItemType.veggie, price: 30, smallImage: avocadoSmallImage, bigImage: avocadoBigImage)
        
        let cucumberSmallImage = UIImage(named: "Cucumber")!
        let cucumberBigImage = UIImage(named: "Cucumber")!
        let cucumber = Item(id: 3, name: "Cucumber", type: ItemType.veggie, price: 30, smallImage: cucumberSmallImage, bigImage: cucumberBigImage)
        
        let kiwiSmallImage = UIImage(named: "kiwi")!
        let kiwiBigImage = UIImage(named: "Kiwi-2")!
        let kiwi = Item(id: 4, name: "Kiwi", type: ItemType.fruit, price: 30, smallImage: kiwiSmallImage, bigImage: kiwiBigImage)
        
        let watermelonSmallImage = UIImage(named: "Watermelon")!
        let watermelonBigImage = UIImage(named: "Watermelon-2")!
        let watermelon = Item(id: 5, name: "Watermelon", type: ItemType.fruit, price: 45, smallImage: watermelonSmallImage, bigImage: watermelonBigImage)
        
        let products:[[Item]] = [[grapefruit, watermelon, kiwi],[avocado, cucumber]]
        return products
    }
    
    func getBanners()->[Banner] {
        
        
        let bananaBannerImage = UIImage(named: "Banner-1")!
        let bananaBanner = Banner( picture: bananaBannerImage, title: "Product of the month", description: "Brazilian Bananas")
        
        let grapefruitBannerImage = UIImage(named: "Banner-2")!
        let grapefruitBanner = Banner(picture: grapefruitBannerImage, title: "Best grapefruits ever", description: "From Africa")
        
        let cucumberBannerImage = UIImage(named: "Banner-3")!
        let cucumberBanner = Banner(picture: cucumberBannerImage, title: "Product of the week", description: "100% organic")
        
        let kiwiBannerImage = UIImage(named: "Banner-4")!
        let kiwiBanner = Banner(picture: kiwiBannerImage, title: "Recommended", description: "Directly from NZ")
        
        
        
        let banners:[Banner] = [bananaBanner, grapefruitBanner, cucumberBanner, kiwiBanner]
        return banners
    }
    
    func getTrolley()->Trolley{
        return trolley
    }
    
    func getItemTypes()->[ItemType]{
        return [ItemType.fruit, ItemType.veggie]
    }
    
}
