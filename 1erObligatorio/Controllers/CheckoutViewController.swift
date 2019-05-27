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
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutCollectionView: UICollectionView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public var trolley = DataModelManager.shared.getTrolley()
    var toolBar = UIToolbar()
    var picker = UIPickerView()
    var selectPicker: Int?
    var selectIndexPath:IndexPath?
    var readOnly = false

    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
        updateTotal()
        alterLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(readOnly) {
            titleLabel.text! = "Purchase Detail"
            checkoutButton.isHidden = true
            checkoutButton.isEnabled = false
            self.trolley = DataModelManager.shared.purchase
            self.updateTotal()
        }
        else{
            self.trolley = DataModelManager.shared.getTrolley()
        }
    }
    
    func updateTotal(){
        totalPriceLabel.text = "$" + String(trolley.getTotalPrice())
    }
    
    func alterLayout(){
        activityIndicator.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.color = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        
        checkoutButton.layer.cornerRadius = 15
        checkoutButton.layer.borderWidth = 2
        checkoutButton.layer.borderColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
    }
    
    func indexHandler(alert: UIAlertAction!){
        trolley.clear()
        self.navigationController?.popViewController(animated: true)
    }
    
    func blockElementsInView(){
        self.view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        totalLabel.isHidden = true
        totalPriceLabel.isHidden = true
        checkoutCollectionView.isHidden = true
        checkoutButton.isHidden = true
        checkoutButton.isEnabled = false
    }
    
    func unblockElementsInView(){
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        totalLabel.isHidden = false
        checkoutCollectionView.isHidden = false
        checkoutButton.isHidden = false
        checkoutButton.isEnabled = true
        
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        if(trolley.isEmpty()){
            let emptyCheckoutAlert = UIAlertController(title: "Failed at checkout", message: "You have to select at least one item to checkout.", preferredStyle: .alert)
            emptyCheckoutAlert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            self.present(emptyCheckoutAlert, animated: true)
        }
        else{
            blockElementsInView()
            activityIndicator.startAnimating()
            DataModelManager.shared.postCheckout() { (okMessage, error) in
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.unblockElementsInView()
                    let errorCheckoutAlert = UIAlertController(title: "Failed at checkout", message: error.localizedDescription, preferredStyle: .alert)
                    errorCheckoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorCheckoutAlert, animated: true, completion: nil)
                }
                
                if let okMessage = okMessage {
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
        if(!readOnly){
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
    }
    
    @objc func onDoneButtonTapped(){
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        let selItem = trolley.toList[selectIndexPath!.row]
        trolley.modifyItem(id: selItem.item!.id!, quantity: selectPicker!)
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

