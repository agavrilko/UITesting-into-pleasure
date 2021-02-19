//
//  POMTestCase.swift
//  UITests
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import XCTest

class POMTestCase: XCTestCase {

    func test_allRightAnswers() throws {
        try XCUIApplication().launchQuestionnaire()
            .verify()
            .start()
            .verify()
            .choose1976()
            .verify()
            .chooseAppleI()
            .verify()
            .chooseApple()
            .verify()
    }

    func test_oneWrongAnswer() throws {
        try XCUIApplication().launchQuestionnaire()
            .verify()
            .start()
            .verify()
            .choose1900()
            .verify()
            .chooseAppleI()
            .verify()
            .chooseApple()
            .verify(score: 66)
    }

    func test_twoWrongAnswer() throws {
        try XCUIApplication().launchQuestionnaire()
            .verify()
            .start()
            .verify()
            .choose1900()
            .verify()
            .choosePlayStation()
            .verify()
            .chooseApple()
            .verify(score: 33)
    }

    func test_allWrongAnswers() throws {
        try XCUIApplication().launchQuestionnaire()
            .verify()
            .start()
            .verify()
            .choose1900()
            .verify()
            .choosePlayStation()
            .verify()
            .choosePotato()
            .verify(score: 0)
    }

}
