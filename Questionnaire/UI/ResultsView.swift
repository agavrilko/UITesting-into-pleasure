//
//  ResultsView.swift
//  Questionnaire
//
//  Created by Oleksandr Havrylko on 2/2/21.
//

import SwiftUI

struct ResultsView: View {

    let manager: QuestionnaireManager

    @EnvironmentObject
    private var coordinator: WelcomeView.NavigationCoordinator

    var body: some View {
        ZStack {
            self.manager.results().map { results in
                VStack {
                    Text("Questionnaire completed")
                    Text("Your score: \(Int(results.score * 100))%")
                        .bold()
                        .padding(.top, 12)
                    Spacer()
                    Text("Tap 'Restart' to try again.")
                        .foregroundColor(.gray)
                        .padding(.bottom, 12)
                    Button {
                        self.coordinator.reset()
                    } label: {
                        Text("Restart")
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }

}
