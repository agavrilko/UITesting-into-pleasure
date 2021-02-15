//
//  QuestionnaireManager.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import Foundation

final class QuestionnaireManager {

    struct Results {
        let rightAnswers: Int
        let totalAnswers: Int
        let score: Float
    }

    enum AnswerError: Error {
        case noCurrentQuestion
        case invalidAnswer
    }

    private struct Progress {

        private(set) var current: Int = 0
        private(set) var answers: [String: String] = [:]

        mutating func answer(question: String, with answer: String) {
            self.current = self.current + 1
            self.answers[question] = answer
        }

    }

    private let questions: [Question]
    private let answers: [String: String]
    private var progress: Progress?

    init(questions: [Question], answers: [String: String]) {
        self.questions = questions
        self.answers = answers
    }

    func currentQuestion() -> Question? {
        self.progress.flatMap { self.question(at: $0.current) }
    }

    func nextQuestion() -> Question? {
        self.progress.flatMap { self.question(at: $0.current + 1) }
    }

    func results() -> Results? {
        self.progress.flatMap { progress in
            self.questions.count == progress.current ? self.results(
                rightAnswers: self.answers.reduce(0) {
                    progress.answers[$1.key] == $1.value ? $0 + 1 : $0
                }
            ) : nil
        }
    }

    func start() {
        NSLog("\(type(of: self)): start")
        self.progress = Progress()
    }

    func choose(answer: Question.Answer) throws {
        NSLog("\(type(of: self)): choose '\(answer)'")
        guard let question = self.currentQuestion() else {
            throw AnswerError.noCurrentQuestion
        }
        guard question.answers.contains(where: { $0.id == answer.id }) else {
            throw AnswerError.invalidAnswer
        }
        self.progress?.answer(
            question: question.id,
            with: answer.id
        )
    }

    // MARK: Private

    private func question(at index: Int) -> Question? {
        index < self.questions.count ? self.questions[index] : nil
    }

    private func results(rightAnswers: Int) -> Results? {
        !self.questions.isEmpty && rightAnswers <= self.questions.count ? Results(
            rightAnswers: rightAnswers,
            totalAnswers: self.questions.count,
            score: Float(rightAnswers) / Float(self.questions.count)
        ) : nil
    }

}
