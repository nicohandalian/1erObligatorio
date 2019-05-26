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
    @IBOutlet weak var checkoutCollectionView: UICollectionView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var trolley = DataModelManager.shared.getTrolley()
    
    var toolBar = UIToolbar()
    var picker = UIPickerView()
    var selectPicker: Int?
    var selectIndexPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
        updateTotal()
        alterLayout()
    }
    
    func updateTotal(){
        totalPriceLabel.text = "$" + String(trolley.getTotalPrice())
    }
    
    func alterLayout(){
        checkoutButton.layer.cornerRadius = 15
        checkoutButton.layer.borderWidth = 2
        checkoutButton.layer.borderColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
    }
    func indexHandler(alert: UIAlertAction!){
        trolley.clear()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        if(trolley.isEmpty()){
            let failCheckoutAlert = UIAlertController(title: "Failed at checkout", message: "You have to select at least one item to checkout.", preferredStyle: .alert)
            
            failCheckoutAlert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            self.present(failCheckoutAlert, animated: true)
        }
        else{
            DataModelManager.shared.postCheckout() { (okMessage, error) in
                if let error = error {
                    let errorCheckoutAlert = UIAlertController(title: "Error at checkout!", message: error.localizedDescription, preferredStyle: .alert)
                    errorCheckoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorCheckoutAlert, animated: true, completion: nil)
                }
                
                if let okMessage = okMessage {
                    // Show alert that the transaction was succesful
                    let checkoutAlert = UIAlertController(title: "Successful checkout!", message: okMessage, preferredStyle: .alert)
                    
                    checkoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.indexHandler))
                    
                    self.present(checkoutAlert, animated: true)
                }
            }
            
        }
        
    }
    
}

extension CheckoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trolley.selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = checkoutCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCollectionViewCell
        
        let selectedItem = trolley.toList[indexPath.row]
        
        cell.setSelectedItem(selectedItem: selectedItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndexPath = indexPath
        
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped(){
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        let selItem = trolley.toList[selectIndexPath!.row]
        trolley.modifyItem(id: selItem.item.id!, quantity: selectPicker!)
        checkoutCollectionView.reloadData()
        updateTotal()
    }
}

extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 7.5, height: (collectionView.frame.height/1.5))
    }
}

extension CheckoutViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectPicker = row+1
    }
}

