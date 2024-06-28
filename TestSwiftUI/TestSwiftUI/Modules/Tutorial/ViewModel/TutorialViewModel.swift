//
//  TutorialViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import Foundation
final class TutorialViewModel: ObservableObject {

    @Published var tutorialState: TutorialState = .myVocabulary

    func switchState() {
        switch tutorialState {
        case .myVocabulary:
            tutorialState = .settings
        case .settings:
            tutorialState = .favourites
        case .favourites:
            print("tutorial views is over")
        }
    }
}

enum TutorialState {
    case myVocabulary, settings, favourites
}
