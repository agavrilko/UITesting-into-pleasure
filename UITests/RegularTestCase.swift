//
//  RegularTestCase.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

class RegularTestCase: XCTestCase {

    func test() throws {

        let application = XCUIApplication()
        application.launch()

        // Wait for the welcome view to appear and validate it
        let welcomeView = application.otherElements["welcome_view"]
        try welcomeView.waitOrThrow(timeout: 1.0)
        try [
            welcomeView.staticTexts.element(label: "Welcome"),
            welcomeView.staticTexts.element(
                label: "This is a simple questionnaire app to demonstrate the power of Page Object pattern."
            ),
            welcomeView.staticTexts.element(label: "Tap 'Start' to begin."),
            welcomeView.buttons.element(label: "Start"),
        ].throwIfDoesNotExist()

        // Proceed to first question and validate it
        try application.buttons.element(label: "Start").tapOrThrow()
        let question1View = application.tables["question_view"]
        try question1View.waitOrThrow(timeout: 1.0)

    }

}
