//
//  ItemViewController.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import UIKit

//Custom Delegation
protocol PushItemToCartControllerDelegate {
    func didAddItemToCart(item: CartItem)
}


private let reuseIdentifier = "Cell"

class ItemViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var delegate: PushItemToCartControllerDelegate?
    
    //Dummy Data
    var list = ["Shoes", "Skateboard", "Watch", "Suit"]
    var imageList = ["pexels-melvin-buezo-2529148", "pexels-messala-ciulla-1018484", "pexels-pixabay-277390", "pexels-pixabay-325876"]
    var imageURLlink = ["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260", "https://images.pexels.com/photos/1018484/pexels-photo-1018484.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260", "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260", "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"]
    var price = [24.88, 20.00, 50.01, 45.89, 75.89, 78.23]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ITEMS"
        
        collectionView.backgroundColor = .darkGray
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    
    // MARK: - DataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        
        cell.itemTitle.text = list[indexPath.row]
        cell.pricing.text = convertToCurrency(price[indexPath.row])
        cell.itemImage.image = UIImage(named: imageList[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Save item in CoreData
        let context = CoreDataManager.shared.persistentContainer.viewContext

        let savedItem = CartItem(context: context)
        let name = list[indexPath.row]
        let priced = price[indexPath.row]
        let imageURL = imageURLlink[indexPath.row]

        let itemImage = UIImage(named: imageList[indexPath.row])

        if let image = itemImage {
            let imageData = image.jpegData(compressionQuality: 0.5)
            savedItem.setValue(imageData, forKey: "imageData")
        }

        savedItem.setValue(name, forKey: "name")
        savedItem.setValue(priced, forKey: "price")
        savedItem.setValue(imageURL, forKey: "imageURL")
        
        do {
            try context.save()
            delay(durationInSeconds: 0.5) {
                let newVC = CartTableViewController()
                self.delegate?.didAddItemToCart(item: savedItem)
                self.navigationController?.pushViewController(newVC, animated: true)
            }
        } catch {
            print("Failed to save item \(error)")
        }
    }
    
    // MARK: - Delegate
    
    fileprivate let minimumGapSpacingBetweenCells: CGFloat = 5

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumGapSpacingBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumGapSpacingBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - minimumGapSpacingBetweenCells) / 2
        let height = width + 80
        return .init(width: width, height: height)
    }
    
}








