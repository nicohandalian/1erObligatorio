//
//  ShoppingHistoryTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/26/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

protocol ShoppingHistoryCollectionViewDelegate {
    func showPurchaseDetail(purchase: Trolley)
}

class ShoppingHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    var purchase: Trolley!
    var shoppingHistoryCollectionViewDelegate: ShoppingHistoryCollectionViewDelegate?
    
    func setPurchase(trolley: Trolley){
        purchase = trolley
        dateLabel.text = trolley.date!.toString()
        totalPriceLabel.text = "$" + trolley.getTotalPrice().description
    }
    
    func alterLayout(){
        self.layer.borderColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        
        detailBtn.layer.cornerRadius = 15
        detailBtn.layer.borderWidth = 2
        detailBtn.layer.borderColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        
    }
    
    @IBAction func showDetailPressed(_ sender: Any) {
        shoppingHistoryCollectionViewDelegate!.showPurchaseDetail(purchase: purchase)
    }
}
