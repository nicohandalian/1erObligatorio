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
    
    func getTrolley()->Trolley{
        return trolley
    }
    
    func getItemTypes()->[ItemType]{
        return [ItemType.diary, ItemType.fruit, ItemType.veggie, ItemType.other]
    }
    
}
