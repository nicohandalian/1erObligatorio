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
    
    var trolley = DataModelManager.getTrolley()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
