//
//  ASAnnotation.swift
//  AugmentedSzczecin
//
//  Created by Wojciech Tyziniec on 10.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAnnotation: NSObject, BLSAugmentedAnnotation {
    
    var poi: ASPOI
    
    init(poi: ASPOI) {
        self.poi = poi
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.poi.latitude as! Double, self.poi.longitude as! Double)
    }
    
    var title: String {
        return self.poi.name!
    }
    
    var subtitle: String {
        return self.poi.tag!
    }
    
}
