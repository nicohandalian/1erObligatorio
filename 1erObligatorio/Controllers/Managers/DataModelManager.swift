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
    var purchase = Trolley()
    
    private init() {
    }
    
    func postCheckout(onCompletion: @escaping (String?, Error?) -> Void) {
        var itemsToPurchase: [PurchasedItem] = []
        trolley.selectedItems.forEach { (_, selectedItem) in
            let itemToPurchase = PurchasedItem(id: selectedItem.item!.id!, quantity: selectedItem.quantity!)
            itemsToPurchase.append(itemToPurchase)
        }
        APIManager.shared.postCheckout(json: itemsToPurchase.toJSON(), onCompletion: { (response: String?, error: Error?) in
            if let error = error {
                onCompletion(nil, error)
            }
            
            if let response = response {
                onCompletion(response, nil)
            }
        })
    }
    
    func getTrolley()->Trolley{
        return trolley
    }
    
    func getItemTypes()->[ItemType]{
        return [ItemType.diary, ItemType.fruit, ItemType.veggie, ItemType.other]
    }
    
    func setPurchaseToShow(purchase: Trolley){
        self.purchase = purchase
    }
}
