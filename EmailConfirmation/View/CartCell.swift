//
//  CartCell.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import UIKit

protocol StepperDelegate: class {
    func stepperDidChange(inCell : UITableViewCell, sender: UIStepper)
}


class CartCell: UITableViewCell {
    
    var cartItems: CartItem? {
        didSet {
            if let imageData = cartItems?.imageData {
                itemImage.image = UIImage(data: imageData)
            }

            itemName.text = cartItems?.name
            priceLabel.text = convertToCurrency(Double(cartItems!.price))
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellView()
        backgroundColor = .white
        
    }
    
    lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var itemName = UILabel(text: "Item Name goes here", textColor: .black, fontSize: 14, fontWeight: .regular, textAlignment: .left)
    lazy var shipmentEstimate = UILabel(text: "Shipment Estimate: 3 - 5 Weeks", textColor: .darkGray, fontSize: 12, fontWeight: .regular, textAlignment: .left)
    lazy var shipmentAvailable = UILabel(text: "Shipment Available: USA", textColor: .darkGray, fontSize: 12, fontWeight: .regular, textAlignment: .left)
    lazy var quantityLabel = UILabel(text: "Cantidad:  ", textColor: .systemBlue, fontSize: 13, fontWeight: .regular)
    lazy var priceLabel = UILabel(text: "456.98", textColor: .darkGray, fontSize: 13, fontWeight: .regular, numberOfLines: 0, textAlignment: .right)
    
    
    
    //MARK: - view setup -
    
    func setupCellView() {
        
        contentView.addSubview(itemImage)
        itemImage.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        itemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        let topStack = UIStackView(arrangedSubviews: [itemName, priceLabel])
        itemName.adjustsFontSizeToFitWidth = true
        itemName.autoresizingMask = .flexibleWidth
        contentView.addSubview(topStack)
        topStack.anchor(top: contentView.topAnchor, leading: itemImage.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 15))
        
        let middleStack = VerticalStackView(arrangedSubviews: [
            shipmentEstimate,
            shipmentAvailable
        ], spacing: 3)
        contentView.addSubview(middleStack)
        middleStack.anchor(top: topStack.bottomAnchor, leading: itemImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


