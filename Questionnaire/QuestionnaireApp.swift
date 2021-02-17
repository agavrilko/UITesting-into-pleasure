//
//  QuestionnaireApp.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import SwiftUI

@main
struct QuestionnaireApp: App {

    let manager = QuestionnaireBuilder()
        .add(question: "Apple company was officially funded at:")
        .add(wrongAnswer: "1900")
        .add(rightAnswer: "1976")
        .add(wrongAnswer: "2020")
        .add(question: "The first product of the Apple company was:")
        .add(rightAnswer: "Apple I")
        .add(wrongAnswer: "Apple II")
        .add(wrongAnswer: "XBox")
        .add(wrongAnswer: "iPhone")
        .add(wrongAnswer: "PlayStation")
        .add(question: "An official logo of the Apple company is:")
        .add(wrongAnswer: "A potato")
        .add(wrongAnswer: "A tomato")
        .add(wrongAnswer: "An orange")
        .add(rightAnswer: "An apple")
        .build()

    var body: some Scene {
        WindowGroup {
            WelcomeView(manager: self.manager)
        }
    }
}
