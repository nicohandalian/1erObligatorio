//
//  ItemTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/29/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!

    var item: Item!
    var trolley =  DataModelManager.shared.getTrolley()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.alterLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }
    
    func alterLayout(){
        self.itemImageView.setRounded()
        
        addButton.layer.cornerRadius = 15
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        
        
        quantityView.layer.cornerRadius = 15
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setItem(item:Item){
        self.item = item
        self.itemImageView.image = item.smallImage
        self.nameLabel.text = item.name
        self.priceLabel.text = "$" + item.price.description
        
        
        guard let quantity = trolley.findItemQuantity(id: item.id) else{
            showAddButton()
            return
        }
        showQuantityView()
        self.quantityLabel.text = String(quantity)
    }
    
    func showAddButton(){
        addButton.isHidden = false
        quantityView.isHidden = true
    }
    
    func showQuantityView(){
        addButton.isHidden = true
        quantityView.isHidden = false
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        showQuantityView()
        let selItem = SelectedItem(item: self.item, quantity: 1)
        trolley.addItem(selItem: selItem)
        quantityLabel.text = "1"
        
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        guard let quantity = trolley.findItemQuantity(id: item.id) else{
            return
        }
        let actualQuantity = quantity+1
        trolley.modifyItem(id: item.id, quantity: actualQuantity)
        quantityLabel.text = String(actualQuantity)
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        guard let quantity = trolley.findItemQuantity(id: item.id) else{
            return
        }
        
        let actualQuantity = quantity-1
        trolley.modifyItem(id: item.id, quantity: actualQuantity)
        
        if(actualQuantity == 0){
            showAddButton()
        }
        else{
            quantityLabel.text = String(actualQuantity)
        }
    }
    
}
