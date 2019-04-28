//
//  IndexViewController.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 4/25/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit

class IndexViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    
    let banners = DataModelManager.getBanners()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    
    
}
