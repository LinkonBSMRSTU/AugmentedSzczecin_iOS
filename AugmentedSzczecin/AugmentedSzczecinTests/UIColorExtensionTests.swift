//
//  UIColorExtensionTests.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class UIColorExtensionTests: XCTestCase {

    func testColorFromHex() {
        XCTAssertEqual(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), UIColor(hex: 0x212121, alpha: 1), "Hex init doesnt work")
    }

}