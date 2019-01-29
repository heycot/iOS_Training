//
//  ExtensionUIKit.swift
//  iOS_Exercise
//
//  Created by Tu (Callie) T. NGUYEN on 1/29/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded(color: UIColor) {
        self.layer.cornerRadius = (self.frame.size.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = color.cgColor
    }
    
    func setShadown() {
//        self.layer.cornerRadius = (self.frame.size.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.size.width / 2).cgPath
        
    }
}

extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
    
}
