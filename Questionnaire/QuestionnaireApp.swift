//
//  QuestionnaireApp.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import SwiftUI
import Combine

@main
struct QuestionnaireApp: App {

    let manager = QuestionnaireManager(
        provider: QuestionsBuilder()
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
            .testingQuestionsPrior()
    )

    var body: some Scene {
        WindowGroup {
            WelcomeView(manager: self.manager)
        }
    }
}

private extension QuestionsBuilder {

    private struct GroupQuestionsProvider: QuestionsProvider {

        let providers: [QuestionsProvider]

        func questions() -> AnyPublisher<Questions, Error> {
            Publishers.MergeMany(self.providers.map { $0.questions() })
                .first()
                .eraseToAnyPublisher()
        }

    }

    func testingQuestionsPrior() -> QuestionsProvider {
        #if DEBUG
        return GroupQuestionsProvider(providers: [
            ProcessInfo.processInfo.questionsProvider(),
            self
        ])
        #else
        return self
        #endif
    }

}
