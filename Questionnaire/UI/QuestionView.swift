//
//  QuestionView.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import SwiftUI

struct QuestionView: View {

    let manager: QuestionnaireManager

    @State
    private var navigationContext: NavigationContext = .idle

    var body: some View {
        ZStack {
            self.manager.currentQuestion().map { question in
                VStack {
                    Text(question.text)
                    List(question.answers) { answer in
                        Button {
                            self.navigationContext = self.manager.evaluate(answer: answer)
                        } label: {
                            Text(answer.text)
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .backgroundNavigation(
            manager: self.manager,
            context: $navigationContext
        )
    }

}

private extension QuestionnaireManager {

    private enum Failure: Error {
        case inappropriateManagerState
    }

    func evaluate(answer: Question.Answer) -> NavigationContext {
        do {
            try self.choose(answer: answer)
            if let question = self.currentQuestion() {
                return .question(question)
            }
            if let results = self.results() {
                return .results(results)
            }
            throw Failure.inappropriateManagerState
        } catch {
            return .idle
        }
    }

}
