//
//  CheckoutTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/1/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import UIKit

class CheckoutCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var selectedItem: SelectedItem!
    var trolley =  DataModelManager.shared.getTrolley()
    
    func setSelectedItem(selectedItem: SelectedItem){
        self.selectedItem = selectedItem
        self.itemImageView.image = selectedItem.item.smallImage
        self.nameLabel.text = selectedItem.item.name
        self.priceLabel.text = "$" + selectedItem.item.price.description
        self.unitsLabel.text = String(selectedItem.quantity) + " units"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        self.itemImageView.addGestureRecognizer(tapGesture)
        
        alterLayout()
    }
    
    
    
    func alterLayout(){
        itemImageView.setRoundedCorners()
    }
    
    @objc func tapGesture(){
        
    }

}

extension UIImageView {
    
    func setRoundedCorners() {
        self.layer.cornerRadius = self.frame.width/15
        self.layer.masksToBounds = true
    }
    
}