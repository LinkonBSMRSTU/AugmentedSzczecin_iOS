//
//  ASAugmentedMenuButton.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 23.06.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAugmentedMenuButton: UIButton {

    var buttonColor: UIColor? {
        willSet(newColor) {
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.borderWidth = 5
            if let color = newColor {
                self.layer.borderColor = color.CGColor
                if !self.isActive {
                    self.tintColor = color
                }
            }
        }
    }
    
    var isActive: Bool {
        willSet(isActive) {
            if isActive {
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.tintColor = UIColor.whiteColor()
                    self.backgroundColor = UIColor(CGColor: self.layer.borderColor)
                })
            } else {
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.tintColor = UIColor(CGColor: self.layer.borderColor)
                    self.backgroundColor = UIColor.whiteColor()
                })
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.isActive = false
        super.init(coder: aDecoder)

    }
    
}
