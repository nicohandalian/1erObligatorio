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
    @IBOutlet weak var checkoutTableView: UITableView!
    
    var items = DataModelManager.shared.getItems()
    var trolley = DataModelManager.shared.getTrolley()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutTableView.dataSource = self
        checkoutTableView.delegate = self
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

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trolley.selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell",for:indexPath) as! CheckoutTableViewCell
        
        let selectedItem = trolley.toList[indexPath.row]
        
        cell.setSelectedItem(selectedItem: selectedItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shopping Cart"
    }
    
    func tableView(_ tabl2eView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return searchBar
    //    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
