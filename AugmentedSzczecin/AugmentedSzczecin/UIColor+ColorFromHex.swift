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
    
    class func mediumBlueAugmentedColor() -> UIColor {
        return self.init(hex: 0x2B75B3, alpha: 1.0)
    }
    
    class func dodgerBlueAugmentedColor() -> UIColor! {
        return self.init(hex: 0x348FD9, alpha: 1.0)
    }
    
    class func lightSkyBlueAugmentedColor() -> UIColor! {
        return self.init(hex: 0xCCE6FF, alpha: 1.0)
    }
    
    class func whiteAugmentedColor() -> UIColor! {
        return self.init(hex: 0xFFFFFF, alpha: 1.0)
    }
    
    class func redAugmentedColor() -> UIColor! {
        return self.init(hex: 0xF25A5A, alpha: 1.0)
    }
    
    class func blackAugmentedColor() -> UIColor! {
        return self.init(hex: 0x212121, alpha: 1.0)
    }
    
    class func grayAugmentedColor() -> UIColor! {
        return self.init(hex: 0x727272, alpha: 1.0)
    }
    
    class func lightGrayAugmentedColor() -> UIColor! {
        return self.init(hex: 0xB6B6B6, alpha: 1.0)
    }
    
}
