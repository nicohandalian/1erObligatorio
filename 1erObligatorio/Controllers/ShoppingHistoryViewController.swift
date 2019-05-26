//
//  ShoppingHistoryViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/21/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class ShoppingHistoryViewController: UIViewController{
    
    @IBOutlet weak var shoppingHistoryCollectionView: UICollectionView!
    
    var purchases:[Trolley] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingHistoryCollectionView.dataSource = self
        shoppingHistoryCollectionView.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        fetchPurchases()
    }
    func fetchPurchases(){
        APIManager.shared.getPurchases(){ purchases, error in
            
//            self.activityIndicator.stopAnimating()
//            self.showElementsInView()
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let purchases = purchases {
                self.purchases = purchases
                self.shoppingHistoryCollectionView.reloadData()
            }
        }
    }
}

extension ShoppingHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = shoppingHistoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingHistoryCell", for: indexPath) as! ShoppingHistoryCollectionViewCell
        
        let trolley = purchases[indexPath.row]
        
        cell.setPurchase(trolley: trolley)
        
        return cell
    }
    
    
}
