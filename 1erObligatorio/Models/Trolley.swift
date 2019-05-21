//
//  Trolley.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/24/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

class Trolley {
    var selectedItems: [Int: SelectedItem] = [:]
    
    var toList:[SelectedItem] {
        get{
            return Array(selectedItems.values)
        }
    }
    
    init() {
    }
    
    func addItem(selItem:SelectedItem) {
        self.selectedItems[selItem.item.id] = selItem
    }
    
    func findItemQuantity(id:Int) -> Int? {
        return self.selectedItems[id]?.quantity
    }
    
    func modifyItem(id: Int, quantity: Int){
        if (quantity <= 0){
            self.selectedItems.removeValue(forKey: id)
        }
        else{
            self.selectedItems[id]!.quantity = quantity
        }
    }
    
    func getTotalPrice()->Float{
        var total:Float = 0
        for (_,selItem) in selectedItems{
            total += (Float(selItem.quantity) * selItem.item.price)
        }
        return total
    }
    
    func clear(){
        self.selectedItems = [:]
    }
    
    func isEmpty()->Bool{
        return selectedItems.isEmpty
    }
    
}
