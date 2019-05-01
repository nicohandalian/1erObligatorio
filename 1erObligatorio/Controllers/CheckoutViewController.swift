//
//  CheckoutViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutCollectionView: UICollectionView!
    
    var items = DataModelManager.shared.getItems()
    var trolley = DataModelManager.shared.getTrolley()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
        totalPriceLabel.text = "$" + String(trolley.getTotalPrice())
        
    }
    
    func indexHandler(alert: UIAlertAction!){
        let indexNavigationController = storyboard?.instantiateViewController(withIdentifier: "IndexViewController") as! IndexViewController
        
        present(indexNavigationController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        trolley.clear()
        
        let alert = UIAlertController(title: "Successful checkout", message: "Your purchase has been made successfully.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: indexHandler))
        
        self.present(alert, animated: true)
        
    }
    
}

extension CheckoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trolley.selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = checkoutCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCollectionViewCell
        
        let selectedItem = trolley.toList[indexPath.row]
        
        cell.setSelectedItem(selectedItem: selectedItem)
        
        return cell
    }
    
    
}
