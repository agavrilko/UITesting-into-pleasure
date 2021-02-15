//
//  QuestionnaireApp.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import SwiftUI

@main
struct QuestionnaireApp: App {

    let manager = QuestionnaireManager(
        questions: [
            Question(
                id: "1",
                text: "A Question",
                answers: [
                    Question.Answer(
                        id: "2",
                        text: "Option 1"
                    ),
                    Question.Answer(
                        id: "3",
                        text: "Option 2"
                    )
                ]
            ),
            Question(
                id: "4",
                text: "B Question",
                answers: [
                    Question.Answer(
                        id: "5",
                        text: "Option 1"
                    ),
                    Question.Answer(
                        id: "6",
                        text: "Option 2"
                    )
                ]
            )
        ],
        answers: [
            "1": "2",
            "4": "6",
        ]
    )

    var body: some Scene {
        WindowGroup {
            WelcomeView(manager: self.manager)
        }
    }
}
