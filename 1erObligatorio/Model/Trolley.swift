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
    
    func findItemAt(id:Int) -> SelectedItem? {
        
        for (let i=0; i<selectedItems.count; i++) {
            if (self.selectedItems[i].
        }
        return nil
    }
    
    func modifyItem(id: Int, quantity: Int){
        if let selItem = self.findItem(id: id) {
            if(quantity == 0){
                self.selectedItems.remo
        }
    }
}
