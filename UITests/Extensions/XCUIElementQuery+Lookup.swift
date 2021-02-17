//
//  XCUIElementQuery+Lookup.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

extension XCUIElementQuery {

    func element(label: String) -> XCUIElement {
        self.lookup(label: label)
    }

    func element(label: String, _ arguments: CVarArg...) -> XCUIElement {
        self.lookup(
            label: String(
                format: label,
                arguments: arguments
            )
        )
    }

    // MARK: Private

    private func lookup(label: String) -> XCUIElement {
        var result = self.element(matching: NSPredicate(format: "label like %@", label))
        if !result.exists {
            // Some labels don't include line breakers
            // So repeat lookup without them
            result = self.element(
                matching: NSPredicate(
                    format: "label like %@", label.replacingOccurrences(
                        of: "\n",
                        with: " ",
                        options: [],
                        range: nil
                    )
                )
            )
        }
        return result
    }

}

