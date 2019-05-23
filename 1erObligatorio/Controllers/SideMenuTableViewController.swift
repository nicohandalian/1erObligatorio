//
//  SideMenuTableViewController.swift
//  SideMenu
//
//  Created by Jon Kent on 4/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
    }
}
