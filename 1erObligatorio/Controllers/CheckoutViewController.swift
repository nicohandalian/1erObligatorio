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
    var trolley = DataModelManager.getTrolley()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func checkouButtonPressed(_ sender: Any) {
        trolley.clear()
        let indexNavigationController = storyboard?.instantiateViewController(withIdentifier: "IndexViewController") as! IndexViewController
        present(indexNavigationController, animated: true, completion: nil)
    }
    
}
