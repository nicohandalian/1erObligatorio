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
    
    @IBOutlet weak var shoppingHistoryTitleLabel: UILabel!
    @IBOutlet weak var shoppingHistoryCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var purchases:[Trolley] = []
    var selectedPurchase: Trolley?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingHistoryCollectionView.dataSource = self
        shoppingHistoryCollectionView.delegate = self
        alterLayout()
        fetchPurchases()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkoutViewController = segue.destination as? CheckoutViewController {
            checkoutViewController.readOnly = true
     
        }
    }
    
    func alterLayout() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        activityIndicator.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        activityIndicator.hidesWhenStopped = true
        
    }
    
    func fetchPurchases(){
        hideElementsInView()
        activityIndicator.startAnimating()
        APIManager.shared.getPurchases(){ purchases, error in
            self.activityIndicator.stopAnimating()
            self.showElementsInView()
            if let error = error {
                let errorPurchaseAlert = UIAlertController(title: "Failed loading purchases", message: error.localizedDescription, preferredStyle: .alert)
                errorPurchaseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorPurchaseAlert, animated: true, completion: nil)
            }
            if let purchases = purchases {
                self.purchases = purchases.sorted(by: { $0.date! > $1.date! })
                self.shoppingHistoryCollectionView.reloadData()
            }
        }
    }
    
    
    func showElementsInView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shoppingHistoryTitleLabel.isHidden = false
        shoppingHistoryCollectionView.isHidden = false
    }
    
    func hideElementsInView() {
        self.view.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        shoppingHistoryTitleLabel.isHidden = true
        shoppingHistoryCollectionView.isHidden = true
        
    }
}

extension ShoppingHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shoppingHistoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingHistoryCell", for: indexPath) as! ShoppingHistoryCollectionViewCell
        cell.alterLayout()
        let trolley = purchases[indexPath.row]
        cell.setPurchase(trolley: trolley)
        cell.shoppingHistoryCollectionViewDelegate = self
        return cell
    }
    
}

extension ShoppingHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}

extension ShoppingHistoryViewController: ShoppingHistoryCollectionViewDelegate {
    func showPurchaseDetail(purchase: Trolley) {
        DataModelManager.shared.setPurchaseToShow(purchase: purchase)
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}
