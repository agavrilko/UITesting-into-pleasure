//
//  Array+Throws.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

extension Array where Element == XCUIElement {

    func throwIfDoesNotExist() throws {
        try self.forEach { try $0.throwIfDoesNotExist() }
    }

}

