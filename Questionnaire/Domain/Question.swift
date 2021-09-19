//
//  Question.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import Foundation

typealias Questions = [Question]

struct Question: Codable, Identifiable {

    struct Answer: Codable, Identifiable {

        let id: String
        let text: String
        let isRight: Bool

    }

    let id: String
    let text: String
    let answers: [Answer]

}
