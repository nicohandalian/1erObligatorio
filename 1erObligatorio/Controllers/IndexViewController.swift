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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var banners:[Banner] = []
    var items: [Item] = []
    let itemTypes = DataModelManager.shared.getItemTypes()
    let trolley = DataModelManager.shared.getTrolley()
    var currentItems = [[Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        alterLayout()
        fetchItems()
        fetchBanners()
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        searchBar.delegate = self
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        itemsTableView.tableHeaderView = searchBar
        setupSideMenu()
        currentItems = loadAllItemsInSections()   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemsTableView.reloadData()
    }
    
    func alterLayout() {
        activityIndicator.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        activityIndicator.hidesWhenStopped = true
        
        itemsTableView.estimatedSectionHeaderHeight = 50
        
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search"
    }
    
    func fetchItems() {
        hideElementsInView()
        activityIndicator.startAnimating()
        
        APIManager.shared.getItems(){ items, error in
            self.activityIndicator.stopAnimating()
            self.showElementsInView()
            
            if let error = error {
                let errorProductAlert = UIAlertController(title: "Failed loading products", message: error.localizedDescription, preferredStyle: .alert)
                errorProductAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorProductAlert, animated: true, completion: nil)
            }
            
            if let items = items {
                self.items = items
                self.currentItems = self.loadAllItemsInSections()
                self.itemsTableView.reloadData()
            }
        }
    }
    
    func fetchBanners() {
        hideElementsInView()
        activityIndicator.startAnimating()
        
        APIManager.shared.getBanners(){ banners, error in
            self.activityIndicator.stopAnimating()
            self.showElementsInView()
            
            if let error = error {
                let errorBannersAlert = UIAlertController(title: "Failed loading banners", message: error.localizedDescription, preferredStyle: .alert)
                errorBannersAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorBannersAlert, animated: true, completion: nil)
            }
            
            if let banners = banners {
                self.banners = banners
                self.bannersCollectionView.reloadData()
            }
        }
    }
    
    func showElementsInView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bannersCollectionView.isHidden = false
        itemsTableView.isHidden = false
        searchBar.isHidden = false
        bannerPageControl.isHidden = false
        bannerPageControl.isEnabled = true
    }
    
    func hideElementsInView() {
        self.view.backgroundColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        bannersCollectionView.isHidden = true
        itemsTableView.isHidden = true
        searchBar.isHidden = true
        bannerPageControl.isHidden = true
        bannerPageControl.isEnabled = false
        
    }
    func loadAllItemsInSections() -> [[Item]]{
        var sections:[[Item]] = [[],[],[],[]]
        for item in items{
            switch item.type!
            {
            case .diary:
                sections[0].append(item)
                break
            case .fruit:
                sections[1].append(item)
                break
            case .veggie:
                sections[2].append(item)
                break
            case .other:
                sections[3].append(item)
                break
            }
        }
        return sections
    }
    
    fileprivate func setupSideMenu() {
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
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannersCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        cell.bannerImageView.kf.setImage(with: banners[indexPath.item].imageUrl)
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
        var amount = 0
        for itemsinsection in currentItems {
            if amount == section {
                return itemsinsection.count
            }
            amount += 1
        }
        return amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemsTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemTableViewCell else{
            return UITableViewCell()
        }
        cell.itemTableViewCellDelegate = self
        let item = currentItems[indexPath.section][indexPath.row]
        guard let quantity = trolley.findItemQuantity(id: item.id!) else{
            cell.setItem(item: item, quantity: 0)
            return cell
        }
        cell.setItem(item: item,quantity: quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = itemTypes[section].rawValue
        var typeWithS = itemTypes[section].rawValue + "s"
        if(type.last! == "y"){
            typeWithS = itemTypes[section].rawValue.dropLast()+"ies"
        }
        return typeWithS
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
            currentItems = loadAllItemsInSections()
            itemsTableView.reloadData()
            return
        }
        for i in 0...loadAllItemsInSections().count-1{
            currentItems[i] = loadAllItemsInSections()[i].filter({item->Bool in
                return item.name!.lowercased().contains(searchText.lowercased())
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
