//
//  RegularTestCase.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

class RegularTestCase: XCTestCase {

    func test_allRightAnswers() throws {

        let application = XCUIApplication()
        application.launch()

        // Wait for the welcome view to appear and validate it
        try [
            application.staticTexts.element(label: "Welcome"),
            application.staticTexts.element(
                label: "This is a simple questionnaire app to demonstrate the power of Page Object pattern."
            ),
            application.staticTexts.element(label: "Tap 'Start' to begin."),
            application.buttons.element(label: "Start"),
        ].throwIfDoesNotExist()

        // Proceed to first question and validate it
        try application.buttons.element(label: "Start").tapOrThrow()
        try [
            application.staticTexts.element(label: "Apple company was officially funded at:"),
            application.tables.cells.buttons.element(label: "1900"),
            application.tables.cells.buttons.element(label: "1976"),
            application.tables.cells.buttons.element(label: "2020"),
        ].throwIfDoesNotExist()

        // Proceed to second question and validate it
        try application.tables.cells.buttons.element(label: "1976").tapOrThrow()
        try [
            application.staticTexts.element(label: "The first product of the Apple company was:"),
            application.tables.cells.buttons.element(label: "Apple I"),
            application.tables.cells.buttons.element(label: "Apple II"),
            application.tables.cells.buttons.element(label: "XBox"),
            application.tables.cells.buttons.element(label: "iPhone"),
            application.tables.cells.buttons.element(label: "PlayStation"),
        ].throwIfDoesNotExist()

        // Proceed to third question and validate it
        try application.tables.cells.buttons.element(label: "Apple I").tapOrThrow()
        try [
            application.staticTexts.element(label: "An official logo of the Apple company is:"),
            application.tables.cells.buttons.element(label: "A potato"),
            application.tables.cells.buttons.element(label: "A tomato"),
            application.tables.cells.buttons.element(label: "An orange"),
            application.tables.cells.buttons.element(label: "An apple"),
        ].throwIfDoesNotExist()

        // Proceed to the results and validate it
        try application.tables.cells.buttons.element(label: "An apple").tapOrThrow()
        try [
            application.staticTexts.element(label: "Questionnaire completed"),
            application.staticTexts.element(label: "Your score: 100%"),
            application.staticTexts.element(label: "Tap 'Restart' to try again."),
            application.buttons.element(label: "Restart"),
        ].throwIfDoesNotExist()

    }

}
