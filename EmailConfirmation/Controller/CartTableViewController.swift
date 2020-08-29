//
//  CartTableViewController.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import UIKit
import CoreData

fileprivate let cellId = "CellID"

class CartTableViewController: UITableViewController, PushItemToCartControllerDelegate {
    
    var cartItemArray: [CartItem] = []
    
    func didAddItemToCart(item: CartItem) {
        cartItemArray.append(item)
        let indexPath = IndexPath(row: cartItemArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Path to CoreData file::: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        
        navigationItem.title = "CART"
        
        let reset = UIBarButtonItem(title: "RESET", style: .done, target: self, action: #selector(self.resetCart))
        let submit = UIBarButtonItem(title: "BUY", style: .plain, target: self, action: #selector(self.sendEmail))
        navigationItem.rightBarButtonItems = [submit, reset]
        tableView.register(CartCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        
    }
    
    @objc func sendEmail() {
        print("send email with items")
    }
    
    
    
    //MARK: - Delete all items from CoreData and View
    
    @objc func resetCart() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: CartItem.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in cartItemArray.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            
            cartItemArray.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            
            self.tableView.reloadData()
            
        } catch {
            print("Failed to delete objects from CoreData: \(error)")
        }
    }
    
    
    //MARK: - -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartItemArray = CoreDataManager.shared.fetchCartItem()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CartCell
        
        let item = cartItemArray[indexPath.row]
        cell.cartItems = item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}


