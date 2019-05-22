//
//  IndexViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

class IndexViewController: UIViewController{
    
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    let banners = DataModelManager.shared.getBanners()
    let items = DataModelManager.shared.getItems()
    let itemTypes = DataModelManager.shared.getItemTypes()
    let trolley = DataModelManager.shared.getTrolley()
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
        
        setupSideMenu()
        alterLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemsTableView.reloadData()
    }
    
    func alterLayout() {
        itemsTableView.estimatedSectionHeaderHeight = 50
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search"
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    @IBAction func moveToPage(_ sender: Any) {
        bannersCollectionView.scrollToItem(at: IndexPath(item: bannerPageControl.currentPage,section: 0), at: .right, animated: true)
    }
    
    @IBAction func checkoutButton(_ sender: Any) {
        if(trolley.isEmpty()){
            let failCheckoutAlert = UIAlertController(title: "Failed at checkout", message: "You have to select at least one item to checkout.", preferredStyle: .alert)
            
            failCheckoutAlert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            self.present(failCheckoutAlert, animated: true)
        }
    }
    
}
extension IndexViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerPageControl.numberOfPages = banners.count
        bannerPageControl.isHidden = !(banners.count > 1)
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannersCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        
        cell.bannerImageView.image = banners[indexPath.item].picture
        cell.bannerImageView.setRoundedCorners()
        cell.bannerTitleLabel.text = banners[indexPath.item].title
        cell.bannerDescriptionLabel.text = banners[indexPath.item].description
        
        return cell
    }
}

extension IndexViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
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
        cell.itemTableViewCellDelegate = self
        let item = currentItems[indexPath.section][indexPath.row]
        guard let quantity = trolley.findItemQuantity(id: item.id) else{
            cell.setItem(item: item, quantity: 0)
            return cell
        }
        cell.setItem(item: item,quantity: quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemTypes[section].rawValue + "s"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

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

extension IndexViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height - 10)
    }
    
}


extension IndexViewController: ItemTableViewDelegate{
    func addSelectedItem(item: Item) -> Int {
        let selItem = SelectedItem(item: item, quantity: 1)
        trolley.addItem(selItem: selItem)
        return 1
    }
    
    func incrementQuantity(id: Int) -> Int {
        guard let quantity = trolley.findItemQuantity(id: id) else{
            return 0
        }
        let actualQuantity = quantity + 1
        trolley.modifyItem(id: id, quantity: actualQuantity)
        return actualQuantity
    }
    
    func decreaseQuantity(id: Int) -> Int {
        guard let quantity = trolley.findItemQuantity(id: id) else{
            return 0
        }
        let actualQuantity = quantity - 1
        trolley.modifyItem(id: id, quantity: actualQuantity)
        return actualQuantity
    }
    
    func getItemQuantity(id: Int) -> Int {
        guard let quantity = trolley.findItemQuantity(id: id) else{
            return 0
        }
        return quantity
        
    }
    
    
}
