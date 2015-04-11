//
//  StringLocalizableExtensionTests.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 11.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import XCTest

class StringLocalizableExtensionTests: XCTestCase {

    func testLocalizedString() {
        XCTAssertEqual("StringMadeOnlyForTests".localized, "TESTS", "Localized string doesn't work")
    }

}
