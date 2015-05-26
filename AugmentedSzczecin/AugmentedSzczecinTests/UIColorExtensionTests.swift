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
    
    func testMediumBlueColor() {
        XCTAssertEqual(UIColor(hex: 0x2B75B3, alpha: 1), UIColor.mediumBlueAugmentedColor(), "Color should be equal")
    }
    
    func testdodgerBlueColor() {
        XCTAssertEqual(UIColor(hex: 0x348FD9, alpha: 1), UIColor.dodgerBlueAugmentedColor(), "Color should be equal")
    }
    
    func testLightSkyBlueColor() {
        XCTAssertEqual(UIColor(hex: 0xCCE6FF, alpha: 1), UIColor.lightSkyBlueAugmentedColor(), "Color should be equal")
    }
    
    func testWhiteColor() {
        XCTAssertEqual(UIColor(hex: 0xFFFFFF, alpha: 1), UIColor.whiteAugmentedColor(), "Color should be equal")
    }
    
    func testRedColor() {
        XCTAssertEqual(UIColor(hex: 0xF25A5A, alpha: 1), UIColor.redAugmentedColor(), "Color should be equal")
    }
    
    func testBlackColor() {
        XCTAssertEqual(UIColor(hex: 0x212121, alpha: 1), UIColor.blackAugmentedColor(), "Color should be equal")
    }
    
    func testGrayColor() {
        XCTAssertEqual(UIColor(hex: 0x727272, alpha: 1), UIColor.grayAugmentedColor(), "Color should be equal")
    }
    
    func testLightGrayColor() {
        XCTAssertEqual(UIColor(hex: 0xB6B6B6, alpha: 1), UIColor.lightGrayAugmentedColor(), "Color should be equal")
    }

}