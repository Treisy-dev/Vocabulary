//
//  TutorialViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

final class TutorialViewModel: ObservableObject {
    private let states = TutorialState.allCases
    var tutorialState: TutorialState {
        states[currentIndex]
    }
    @Published var currentIndex: Int = 0
    @Published var isTutorialFinished: Bool = false

    func nextState() {
        if currentIndex < states.count - 1 {
            currentIndex += 1
        } else {
            isTutorialFinished = true
        }
    }

    func previousState() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}

enum TutorialState: CaseIterable {
    case myVocabulary, settings, favourites
}
