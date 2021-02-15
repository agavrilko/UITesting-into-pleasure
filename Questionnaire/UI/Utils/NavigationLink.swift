//
//  NavigationLink.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/15/21.
//

import SwiftUI

enum NavigationContext {

    case idle
    case question(Question)
    case results(QuestionnaireManager.Results)

}

extension NavigationLink where Destination == QuestionView, Label == EmptyView {

    static func questionLink(manager: QuestionnaireManager, navigation: Binding<NavigationContext>) -> NavigationLink {
        NavigationLink(
            destination: QuestionView(manager: manager),
            isActive: Binding {
                switch navigation.wrappedValue {
                case .question: return true
                default: return false
                }
            } set: { _ in
                navigation.wrappedValue = .idle
            },
            label: {
                EmptyView()
            }
        )
    }

}

extension NavigationLink where Destination == ResultsView, Label == EmptyView {

    static func resultsLink(manager: QuestionnaireManager, navigation: Binding<NavigationContext>) -> NavigationLink {
        NavigationLink(
            destination: ResultsView(manager: manager),
            isActive: Binding {
                switch navigation.wrappedValue {
                case .results: return true
                default: return false
                }
            } set: { _ in
                navigation.wrappedValue = .idle
            },
            label: {
                EmptyView()
            }
        )
    }

}

extension View {

    func backgroundNavigation(manager: QuestionnaireManager, context: Binding<NavigationContext>) -> some View {
        self.background(
            VStack {
                NavigationLink.questionLink(
                    manager: manager,
                    navigation: context
                )
                NavigationLink.resultsLink(
                    manager: manager,
                    navigation: context
                )
            }
        )
    }

}
