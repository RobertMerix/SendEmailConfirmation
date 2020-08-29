//
//  ItemCell.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    lazy var itemTitle = UILabel(text: "", textColor: .darkGray, fontSize: 13, fontWeight: .bold)
    lazy var pricing = UILabel(text: "", textColor: .darkGray, fontSize: 12, fontWeight: .semibold)
    
    lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(named: "silver-linked-bracelet-silver-and-black-round-chronograph-190819")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemTitle.adjustsFontSizeToFitWidth = true
        itemTitle.numberOfLines = 2
        pricing.adjustsFontSizeToFitWidth = true
        itemTitle.autoresizingMask = .flexibleWidth
        
        
        backgroundColor = .white
        addSubview(itemImage)
        itemImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: frame.width, height: frame.width))
        itemImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            itemTitle,
            pricing,
        ], spacing: 3)
        addSubview(stackView)
        stackView.anchor(top: itemImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 3, left: 0, bottom: 5, right: 0))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}









