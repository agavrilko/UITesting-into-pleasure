//
//  ResultsPageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class ResultsPageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try self.verify(timeout: timeout, score: 100)
    }

    @discardableResult
    func verify(timeout: TimeInterval = Consts.defaultTimeout, score: Int) throws -> Self {
        try [
            self.application.staticTexts.element(label: "Questionnaire completed"),
            self.application.staticTexts.element(label: "Your score: \(score)%"),
            self.application.staticTexts.element(label: "Tap 'Restart' to try again."),
            self.application.buttons.element(label: "Restart"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func restart(timeout: TimeInterval = Consts.defaultTimeout) throws -> WelcomePageObject {
        try self.application.buttons.element(label: "Restart").tapOrThrow(timeout: timeout)
        return WelcomePageObject(application: self.application)
    }

}

