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
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
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
        itemsTableView.estimatedSectionHeaderHeight = 50
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search"
    }
    
    @IBAction func moveToPage(_ sender: Any) {
        bannersCollectionView.scrollToItem(at: IndexPath(item: bannerPageControl.currentPage,section: 0), at: .right, animated: true)
    }
    
    @IBAction func checkoutButton(_ sender: Any) {
        let checkoutNavigationController = storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        present(checkoutNavigationController, animated: true, completion: nil)
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
        let item = currentItems[indexPath.section][indexPath.row]
        
        cell.setItem(item: item)
        
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
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView()
//
//        let sectionLabel = UILabel(frame: CGRect(x: 8, y: 28, width:
//            tableView.bounds.size.width, height: tableView.bounds.size.height))
//        sectionLabel.font = UIFont(name: "Helvetica", size: 22)
//        sectionLabel.textColor = UIColor.black
//        sectionLabel.text = itemTypes[section].rawValue + "s"
//        sectionLabel.sizeToFit()
//        headerView.addSubview(sectionLabel)
//
//        return headerView
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
