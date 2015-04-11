//
//  ASAnnotation.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 11.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAnnotation: NSObject, BLSAugmentedAnnotation {
   
    let type: String
    let coordinate: CLLocationCoordinate2D
    
    init(type: String, withCoordinate coordinate: CLLocationCoordinate2D) {
        self.type = type
        self.coordinate = coordinate
    }
    
}
