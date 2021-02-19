//
//  Question2PageObject.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/17/21.
//

import XCTest

class Question2PageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try [
            self.application.staticTexts.element(label: "The first product of the Apple company was:"),
            self.application.tables.cells.buttons.element(label: "Apple I"),
            self.application.tables.cells.buttons.element(label: "Apple II"),
            self.application.tables.cells.buttons.element(label: "XBox"),
            self.application.tables.cells.buttons.element(label: "iPhone"),
            self.application.tables.cells.buttons.element(label: "PlayStation"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func chooseAppleI(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question3PageObject {
        try self.application.tables.cells.buttons.element(label: "Apple I").tapOrThrow(timeout: timeout)
        return Question3PageObject(application: self.application)
    }

    @discardableResult
    func chooseAppleII(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question3PageObject {
        try self.application.tables.cells.buttons.element(label: "Apple II").tapOrThrow(timeout: timeout)
        return Question3PageObject(application: self.application)
    }

    @discardableResult
    func chooseXBox(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question3PageObject {
        try self.application.tables.cells.buttons.element(label: "XBox").tapOrThrow(timeout: timeout)
        return Question3PageObject(application: self.application)
    }

    @discardableResult
    func chooseIPhone(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question3PageObject {
        try self.application.tables.cells.buttons.element(label: "iPhone").tapOrThrow(timeout: timeout)
        return Question3PageObject(application: self.application)
    }

    @discardableResult
    func choosePlayStation(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question3PageObject {
        try self.application.tables.cells.buttons.element(label: "PlayStation").tapOrThrow(timeout: timeout)
        return Question3PageObject(application: self.application)
    }

}
