//
//  XCUIElement+Throws.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

extension XCUIElement {

    enum Exceptions: Error, CustomStringConvertible {

        case elementDoesNotExist(String)
        case elementIsNotHittable(String)
        case elementIsNotEnabled(String)

        var description: String {
            switch self {
            case let .elementDoesNotExist(id): return "Element '\(id)' does not exist"
            case let .elementIsNotHittable(id): return "Element '\(id)' is not hittable"
            case let .elementIsNotEnabled(id): return "Element '\(id)' is not enabled"
            }
        }

    }

    func throwIfDoesNotExist(timeout: TimeInterval = 1.0) throws {
        if !self.exists, !self.waitForExistence(timeout: timeout) {
            throw Exceptions.elementDoesNotExist(self.debugElementDescription())
        }
    }

    func tapOrThrow(timeout: TimeInterval = 1.0) throws {
        let overdueDate = Date(timeIntervalSinceNow: timeout)
        try self.throwIfDoesNotExist(timeout: timeout)
        if !self.isHittable {
            RunLoop.current.run(until: overdueDate)
        }
        guard self.isHittable else {
            throw Exceptions.elementIsNotHittable(self.debugElementDescription())
        }
        guard self.isEnabled else {
            throw Exceptions.elementIsNotEnabled(self.debugElementDescription())
        }
        self.tap()
    }

    // MARK: Private

    private func debugElementDescription() -> String {
        [self.identifier, self.label].first { $0.count > 0 } ?? "unknown"
    }

}

