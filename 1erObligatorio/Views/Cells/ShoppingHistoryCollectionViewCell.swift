//
//  ShoppingHistoryTableViewCell.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/26/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class ShoppingHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var purchase: Trolley!
    
    func setPurchase(trolley: Trolley){
        purchase = trolley
        dateLabel.text = "1"
        totalPriceLabel.text = "$" + trolley.getTotalPrice().description
    }
    
    @IBAction func showDetailPressed(_ sender: Any) {
    }
}
