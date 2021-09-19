//
//  QuestionsBuilder.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import Foundation
import Combine

final class QuestionsBuilder {

    private let idGen: IdGenerator
    private var questionFactories: [QuestionFactory]

    init() {
        self.idGen = IdGenerator(prefix: "ID")
        self.questionFactories = []
    }

    func add(question text: String) -> Self {
        self.questionFactories.append(
            QuestionFactory(
                idGen: self.idGen,
                text: text
            )
        )
        return self
    }

    func add(rightAnswer text: String) -> Self {
        // NOTE: Multiple right answers are not supported.
        if let factory = self.questionFactories.last, !factory.containsRightAnswer() {
            factory.add(answer: text, isRight: true)
        }
        return self
    }

    func add(wrongAnswer text: String) -> Self {
        if let factory = self.questionFactories.last {
            factory.add(answer: text, isRight: false)
        }
        return self
    }

    func questions() -> Questions {
        self.questionFactories.map { $0.question() }
    }

}

extension QuestionsBuilder: QuestionsProvider {

    // MARK: QuestionsProvider

    func questions() -> AnyPublisher<Questions, Error> {
        Future { $0(.success(self.questions())) }
            .eraseToAnyPublisher()
    }

}

private final class QuestionFactory {

    private final class AnswerFactory {

        let idGen: IdGenerator
        let text: String
        let isRight: Bool

        init(
            idGen: IdGenerator,
            text: String,
            isRight: Bool
        ) {
            self.idGen = idGen
            self.text = text
            self.isRight = isRight
        }

        func answer() -> Question.Answer {
            Question.Answer(
                id: self.idGen.next(),
                text: self.text,
                isRight: self.isRight
            )
        }

    }

    private let idGen: IdGenerator
    private let text: String
    private var answerFactories: [AnswerFactory]

    init(idGen: IdGenerator, text: String) {
        self.idGen = idGen
        self.text = text
        self.answerFactories = []
    }

    func add(answer text: String, isRight: Bool) {
        self.answerFactories.append(
            AnswerFactory(
                idGen: self.idGen,
                text: text,
                isRight: isRight
            )
        )
    }

    func question() -> Question {
        Question(
            id: self.idGen.next(),
            text: self.text,
            answers: self.answerFactories.map { $0.answer() }
        )
    }

}

private final class IdGenerator {

    private let format: String
    private var seed: UInt32

    convenience init(prefix: String) {
        self.init(format: "\(prefix).%\(PRIuFAST32)")
    }

    init(format: String) {
        self.format = format
        self.seed = .max
    }

    func next() -> String {
        String(format: self.format, self.seed.next())
    }

}

private extension QuestionFactory {

    func containsRightAnswer() -> Bool {
        self.answerFactories.first { $0.isRight } != nil
    }

}

private extension UInt32 {

    mutating func next() -> UInt32 {
        switch self {

        case .min:
            self = .max
            return .min

        default:
            defer { self -= 1 }
            return self

        }
    }

}
