//
//  XCUIElement+Throws.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

extension XCUIElement {

    enum Exceptions: Error {
        case elementDoesNotExist(String)
        case elementIsNotEnabled(String)
    }

    func throwIfDoesNotExist() throws {
        if !self.exists {
            throw Exceptions.elementDoesNotExist(self.debugElementDescription())
        }
    }

    func waitOrThrow(timeout: TimeInterval) throws {
        if !self.waitForExistence(timeout: timeout) {
            throw Exceptions.elementDoesNotExist(self.debugElementDescription())
        }
    }

    func tapOrThrow() throws {
        try self.throwIfDoesNotExist()
        guard self.isEnabled else {
            throw Exceptions.elementIsNotEnabled(self.debugElementDescription())
        }
        self.tap()
    }

    // MARK: Private

    private func debugElementDescription() -> String {
        // TODO: Findout the best properties to identify element.
        // Identifier is not always known, so it can't be used here this way.
        return "\(self.identifier)"
    }

}

