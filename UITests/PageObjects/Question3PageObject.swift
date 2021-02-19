//
//  Question3PageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class Question3PageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try [
            self.application.staticTexts.element(label: "An official logo of the Apple company is:"),
            self.application.tables.cells.buttons.element(label: "A potato"),
            self.application.tables.cells.buttons.element(label: "A tomato"),
            self.application.tables.cells.buttons.element(label: "An orange"),
            self.application.tables.cells.buttons.element(label: "An apple"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func choosePotato(timeout: TimeInterval = Consts.defaultTimeout) throws -> ResultsPageObject {
        try self.application.tables.cells.buttons.element(label: "A potato").tapOrThrow(timeout: timeout)
        return ResultsPageObject(application: self.application)
    }

    @discardableResult
    func chooseTomato(timeout: TimeInterval = Consts.defaultTimeout) throws -> ResultsPageObject {
        try self.application.tables.cells.buttons.element(label: "A tomato").tapOrThrow(timeout: timeout)
        return ResultsPageObject(application: self.application)
    }

    @discardableResult
    func chooseOrange(timeout: TimeInterval = Consts.defaultTimeout) throws -> ResultsPageObject {
        try self.application.tables.cells.buttons.element(label: "An orange").tapOrThrow(timeout: timeout)
        return ResultsPageObject(application: self.application)
    }

    @discardableResult
    func chooseApple(timeout: TimeInterval = Consts.defaultTimeout) throws -> ResultsPageObject {
        try self.application.tables.cells.buttons.element(label: "An apple").tapOrThrow(timeout: timeout)
        return ResultsPageObject(application: self.application)
    }

}
