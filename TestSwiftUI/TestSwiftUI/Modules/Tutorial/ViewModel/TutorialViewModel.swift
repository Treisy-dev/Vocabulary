//
//  TutorialViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI
final class TutorialViewModel: ObservableObject {
    @Published var tutorialState: TutorialState = .myVocabulary
    @Published var currentIndex: Int = 0 {
        didSet {
            updateTutorialState()
        }
    }
    @Published var isTutorialFinished: Bool = false

    private func updateTutorialState() {
        switch currentIndex {
        case 0:
            tutorialState = .myVocabulary
        case 1:
            tutorialState = .settings
        case 2:
            tutorialState = .favourites
        default:
            isTutorialFinished = true
            currentIndex = 2
        }
    }

    func switchState() {
        if currentIndex < 2 {
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

enum TutorialState {
    case myVocabulary, settings, favourites
}
