//
//  ASAnnotationView.swift
//  AugmentedSzczecin
//
//  Created by Sebastian Jędruszkiewicz on 30/04/15.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAnnotationView : BLSAugmentedAnnotationView {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    class func nibName() -> String {
        return "ASAnnotationView"
    }
    
    class func view() -> ASAnnotationView? {
        let bundle = NSBundle(forClass: ASAnnotationView.classForCoder())
        return UIView.loadFromNibNamed(ASAnnotationView.nibName(), bundle: bundle) as? ASAnnotationView
    }
}
