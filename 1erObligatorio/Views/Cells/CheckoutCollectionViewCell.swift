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
    
    func setSelectedItem(selectedItem: SelectedItem){
        self.selectedItem = selectedItem
        self.itemImageView.kf.setImage(with: selectedItem.item!.imageUrl)
        self.nameLabel.text = selectedItem.item!.name
        self.priceLabel.text = "$" + selectedItem.item!.price!.description
        var unitLabelText = String(selectedItem.quantity!) + " unit"
        if(selectedItem.quantity!>1){
            unitLabelText += "s"
        }
        self.unitsLabel.text = unitLabelText
        alterLayout()
    }
    
    func alterLayout(){
        itemImageView.setRoundedCorners()
    }
}
