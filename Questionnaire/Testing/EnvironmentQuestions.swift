//
//  EnvironmentQuestions.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 5/18/21.
//

import Foundation
import Combine

private enum EnvironmentKey: String {
    case questions
}

private struct EnvironmentQuestions: QuestionsProvider  {

    enum Exceptions: Error {
        case questionsNotConfigured
        case invalidArgumentAssigned
        case invalidJSONFormat(Error)
    }

    private let processInfo: ProcessInfo
    private let decoder: JSONDecoder

    init(processInfo: ProcessInfo, decoder: JSONDecoder) {
        self.processInfo = processInfo
        self.decoder = decoder
    }

    // MARK: QuestionsProvider

    func questions() -> AnyPublisher<Questions, Error> {
        Future { promise in

            guard let param = self.processInfo.environment[.questions] else {
                promise(.failure(EnvironmentQuestions.Exceptions.questionsNotConfigured))
                return
            }

            guard let data = Data(base64Encoded: param) else {
                promise(.failure(EnvironmentQuestions.Exceptions.invalidArgumentAssigned))
                return
            }

            do {
                promise(.success(try self.decoder.decode(Questions.self, from: data)))
            } catch {
                promise(.failure(EnvironmentQuestions.Exceptions.invalidJSONFormat(error)))
            }

        }.eraseToAnyPublisher()
    }

}

extension Dictionary where Key == String, Value == String {

    func with(questions builder: QuestionsBuilder) -> Self {
        var result = self
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(builder.questions()) {
            result[.questions] = data.base64EncodedString()
        }
        return result
    }

}

extension ProcessInfo {

    func questionsProvider() -> QuestionsProvider {
        EnvironmentQuestions(processInfo: self, decoder: JSONDecoder())
    }

}

private extension Dictionary where Key == String, Value == String {

    subscript(environmentKey: EnvironmentKey) -> String? {
        get { self[environmentKey.rawValue] }
        set { self[environmentKey.rawValue] = newValue }
    }

}

