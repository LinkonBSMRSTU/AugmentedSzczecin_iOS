//
//  UIView+Xib.swift
//  AugmentedSzczecin
//
//  Created by Sebastian Jędruszkiewicz on 30/04/15.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibName: String, bundle : NSBundle? = nil) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiateWithOwner(nil, options: nil).first as? UIView
    }
}
