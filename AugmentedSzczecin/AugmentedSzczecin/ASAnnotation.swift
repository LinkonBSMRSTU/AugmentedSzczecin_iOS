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
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    
    init(poi: ASPOI, id: Int, coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.poi = poi
        self.title = self.poi.name!
        self.subtitle = self.poi.tag!
        self.coordinate = CLLocationCoordinate2DMake(self.poi.latitude as! Double, self.poi.longitude as! Double)
    }
}
