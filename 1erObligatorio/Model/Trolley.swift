//
//  Trolley.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class Trolley {
    var selectedItems: [SelectedItem] = []
    
    init() {
    }
    
    func addItem(item:SelectedItem) {
        self.selectedItems.append(item)
    }
    
    func findItemAt(id:Int) -> Int? {
        
        for i in 0...selectedItems.count {
            if(selectedItems[i].item.id == id){
                return i
            }
        }
        return nil
    }
    
    func modifyItem(id: Int, quantity: Int){
        if let selItemAt = self.findItemAt(id: id) {
            if (quantity <= 0){
                self.selectedItems.remove(at: selItemAt)
            }
            else{
                self.selectedItems[selItemAt].quantity = quantity
            }
        }
    }
}
