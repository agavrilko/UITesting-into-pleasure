//
//  WelcomePageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class WelcomePageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try [
            self.application.staticTexts.element(label: "Welcome"),
            self.application.staticTexts.element(
                label: "This is a simple questionnaire app to demonstrate the power of Page Object pattern."
            ),
            self.application.staticTexts.element(label: "Tap 'Start' to begin."),
            self.application.buttons.element(label: "Start"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func start(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question1PageObject {
        try self.application.buttons.element(label: "Start").tapOrThrow(timeout: timeout)
        return Question1PageObject(application: self.application)
    }
    
}

extension XCUIApplication {

    func launchQuestionnaire() -> WelcomePageObject {
        self.launch()
        return WelcomePageObject(application: self)
    }

}
