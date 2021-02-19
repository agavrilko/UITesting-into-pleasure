//
//  PageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class PageObject {

    struct Consts {
        static let defaultTimeout: TimeInterval = 1.0
    }

    let application: XCUIApplication

    required init(application: XCUIApplication) {
        self.application = application
    }

    @discardableResult
    func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        return self
    }

}
