//
//  Question1PageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class Question1PageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try [
            self.application.staticTexts.element(label: "Apple company was officially funded at:"),
            self.application.tables.cells.buttons.element(label: "1900"),
            self.application.tables.cells.buttons.element(label: "1976"),
            self.application.tables.cells.buttons.element(label: "2020"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func choose1900(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question2PageObject {
        try self.application.tables.cells.buttons.element(label: "1900").tapOrThrow(timeout: timeout)
        return Question2PageObject(application: self.application)
    }

    @discardableResult
    func choose1976(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question2PageObject {
        try self.application.tables.cells.buttons.element(label: "1976").tapOrThrow(timeout: timeout)
        return Question2PageObject(application: self.application)
    }

    @discardableResult
    func choose2020(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question2PageObject {
        try self.application.tables.cells.buttons.element(label: "2020").tapOrThrow(timeout: timeout)
        return Question2PageObject(application: self.application)
    }

}
