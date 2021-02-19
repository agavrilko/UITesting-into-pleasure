//
//  WelcomeView.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/1/21.
//

import SwiftUI

struct WelcomeView: View {

    class NavigationCoordinator: ObservableObject {

        private(set) var rootContext: Binding<NavigationContext>

        init(rootContext: Binding<NavigationContext>) {
            self.rootContext = rootContext
        }

        public func reset() {
            self.rootContext.wrappedValue = .idle
        }

    }

    public let manager: QuestionnaireManager

    @State
    private var context: NavigationContext = .idle

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome")
                    .bold()
                    .padding(.bottom, 24)
                Text("This is a simple questionnaire app to demonstrate the power of Page Object pattern.")
                    .padding(.horizontal, 64)
                Spacer()
                Text("Tap 'Start' to begin.")
                    .foregroundColor(.gray)
                    .padding(.bottom, 12)
                Button {
                    self.context = self.manager.evaluateStart()
                } label: {
                    Text("Start")
                }
            }.backgroundNavigation(
                manager: self.manager,
                context: self.$context
            )
        }.navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(NavigationCoordinator(rootContext: self.$context))
    }

}

private extension QuestionnaireManager {

    func evaluateStart() -> NavigationContext {
        self.start()
        if let question = self.currentQuestion() {
            return .question(question)
        }
        if let results = self.results() {
            return .results(results)
        }
        return .idle
    }

}
