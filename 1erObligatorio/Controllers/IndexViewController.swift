//
//  IndexViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class IndexViewController: UIViewController{
    
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let banners = DataModelManager.shared.getBanners()
    let items = DataModelManager.shared.getItems()
    let itemTypes = DataModelManager.shared.getItemTypes()

    var currentItems = [[Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentItems = items
        
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        
        searchBar.delegate = self
        
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        
        self.itemsTableView.tableHeaderView = searchBar
        
        alterLayout()
        
    }
    
    func alterLayout() {
        itemsTableView.tableHeaderView = UIView()
        itemsTableView.estimatedSectionHeaderHeight = 50
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search items by Name"
    }
    
    
    @IBAction func checkoutButton(_ sender: Any) {
        let checkoutNavigationController = storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        present(checkoutNavigationController, animated: true, completion: nil)
    }
    
}
extension IndexViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannersCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        
        cell.bannerImageView.image = banners[indexPath.item].picture
        cell.bannerTitleLabel.text = banners[indexPath.item].title
        cell.bannerDescriptionLabel.text = banners[indexPath.item].description
        
        return cell
    }
}

extension IndexViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemsTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemTableViewCell else{
            return UITableViewCell()
        }
        let item = currentItems[indexPath.section][indexPath.row]
        
        cell.setItem(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemTypes[section].rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemTypes.count
    }
    
    func tableView(_ tabl2eView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return searchBar
    //    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension IndexViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentItems = items
            itemsTableView.reloadData()
            return
        }
        
        for i in 0...items.count-1{
            currentItems[i] = items[i].filter({item->Bool in
                return item.name.lowercased().contains(searchText.lowercased())
            })
        }
        itemsTableView.reloadData()
    }
    
}
