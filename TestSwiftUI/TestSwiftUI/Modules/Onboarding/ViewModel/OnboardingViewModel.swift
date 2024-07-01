//
//  OnboardingViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {

    @AppStorage("isFirstEntry") var isFirstEntry: Bool = true
    @Published var onboardingState: OnboardingState = .words

    func switchState() {
        switch onboardingState {
        case .words:
            onboardingState = .comments
        case .comments:
            onboardingState = .rating
        case .rating:
            isFirstEntry = false
        }
    }
}

enum OnboardingState {
    case words, comments, rating
}
