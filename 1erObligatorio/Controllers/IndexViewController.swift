//
//  IndexViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class IndexViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func checkoutButton(_ sender: Any) {
        let checkoutNavigationController = storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        present(checkoutNavigationController, animated: true, completion: nil)
    }
    
    let banners = DataModelManager.getBanners()
    let items = DataModelManager.getItems()
    var trolley = DataModelManager.getTrolley()
    var currentItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentItems = items
        
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        
        searchBar.delegate = self

        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        
        alterLayout()
        
    }
    
    func alterLayout() {
        itemsTableView.tableHeaderView = UIView()
        itemsTableView.estimatedSectionHeaderHeight = 50
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search item by Name"
    }
    
    
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemsTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemTableViewCell else{
            return UITableViewCell()
        }
        let item = currentItems[indexPath.row]
        
        cell.itemImageView.image = item.smallImage
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "$" + item.price.description
        
//        guard let i = trolley.findItemAt(id: item.id) else{
//
//            return cell
//        }
        
        return cell
    }
    
    func tableView(_ tabl2eView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentItems = items
            itemsTableView.reloadData()
            return
        }
        
        currentItems = items.filter({ item->Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        })

        itemsTableView.reloadData()
    }
    
}

