//
//  IndexViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class IndexViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let banners = DataModelManager.getBanners()
    let items = DataModelManager.getItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemsTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemTableViewCell else{
            return UITableViewCell()
        }
        cell.itemImageView.image = items[indexPath.row].smallImage
        cell.nameLabel.text = items[indexPath.row].name
        cell.priceLabel.text = "$" + items[indexPath.row].price.description
        
        return cell
    }
    
}
