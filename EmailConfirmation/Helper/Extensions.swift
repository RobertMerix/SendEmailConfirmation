//
//  Extensions.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight, numberOfLines: Int = 0, textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: "Avenir Next", size: fontSize)
        self.font = .monospacedSystemFont(ofSize: fontSize, weight: fontWeight)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
