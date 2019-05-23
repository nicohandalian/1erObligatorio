//
//  ItemTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/29/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import UIKit
import Kingfisher

protocol ItemTableViewDelegate {
    func addSelectedItem(item: Item) -> Int
    func incrementQuantity(id: Int) -> Int
    func decreaseQuantity(id: Int) -> Int
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!

    var item: Item!
    var itemTableViewCellDelegate: ItemTableViewDelegate?
    
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
    
    func setItem(item:Item, quantity: Int){
        self.item = item
        
        self.itemImageView.kf.setImage(with: item.imageUrl)
        
        self.nameLabel.text = item.name
        self.priceLabel.text = "$" + item.price!.description
        
        if(quantity>0){
            showQuantityView()
            self.quantityLabel.text = String(quantity)
        }
        else{
            showAddButton()
        }
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
        let actualQuantity = itemTableViewCellDelegate!.addSelectedItem(item: item)
        quantityLabel.text = String(actualQuantity)

        
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        let actualQuantity = itemTableViewCellDelegate!.incrementQuantity(id: item.id!)
        quantityLabel.text = String(actualQuantity)

    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        let actualQuantity = itemTableViewCellDelegate!.decreaseQuantity(id: item.id!)
        if(actualQuantity == 0){
            showAddButton()
        }
        else{
            quantityLabel.text = String(actualQuantity)
        }
    
    }
    
}
