//
//  StringValidation.swift
//  AugmentedSzczecin
//
//  Created by pyhu on 19.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation


extension String {
    func isEmailValid() -> Bool {
        let regex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}
extension String {
    func isPasswordValid() -> Bool {
        let regex = NSRegularExpression(pattern: "^[\\s]{4,14}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}
