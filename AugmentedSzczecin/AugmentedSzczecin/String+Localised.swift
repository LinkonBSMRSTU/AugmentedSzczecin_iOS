//
//  String+Localised.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 11.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}