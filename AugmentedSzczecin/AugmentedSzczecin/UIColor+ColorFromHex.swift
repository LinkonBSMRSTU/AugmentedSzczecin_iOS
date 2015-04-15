//
//  UIColor+ColorFromHex.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 15.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat) {
        
        let components = (
            Red: CGFloat((hex >> 16) & 0xff) / 255,
            Green: CGFloat((hex >> 08) & 0xff) / 255,
            Blue: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.Red, green: components.Green, blue: components.Blue, alpha: alpha)
        
    }
    
}
