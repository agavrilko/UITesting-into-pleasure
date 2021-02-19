//
//  Array+Throws.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

extension Array where Element == XCUIElement {

    func throwIfDoesNotExist(timeout: TimeInterval = 1.0) throws {
        for i in 0..<self.count {
            try self[i].throwIfDoesNotExist(timeout: i == 0 ? timeout : 0.0)
        }
    }

}

