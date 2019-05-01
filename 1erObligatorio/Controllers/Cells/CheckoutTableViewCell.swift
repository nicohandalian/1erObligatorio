//
//  CheckoutTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/1/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    
    var selectedItem: SelectedItem!
    var trolley =  DataModelManager.shared.getTrolley()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setSelectedItem(selectedItem: SelectedItem){
        self.selectedItem = selectedItem
        self.itemImageView.image = selectedItem.item.smallImage
        self.nameLabel.text = selectedItem.item.name
        self.priceLabel.text = "$" + selectedItem.item.price.description
        self.unitsLabel.text = String(selectedItem.quantity) + " units"
    }

}
