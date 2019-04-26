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
        
        let avocadoImage = UIImage(named: "images/Avocado")!
        let avocado = Item(id: 1, name: "Avocado", type: ItemType.veggie, price: 30, smallImage: avocadoImage, bigImage: avocadoImage)
        
        let products:[Item] = [avocado]
        return products
    }
    
    static func getBanners()->[Banner] {
        
        
        let banners:[Banner] = []
        return banners
    }
    
}
