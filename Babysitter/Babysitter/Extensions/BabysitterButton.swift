//
//  BabysitterButton.swift
//  Babysitter
//
//  Created by Michael Cannell on 9/16/18.
//  Copyright © 2018 Altrius Ltd. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BabysitterButton: UIButton {

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.backgroundColor = UIColor.blue
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font =  UIFont(name: "Avenir", size: 20)
    }
    
}

