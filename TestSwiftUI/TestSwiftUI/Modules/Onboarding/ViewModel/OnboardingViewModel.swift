//
//  OnboardingViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {

    @AppStorage("isFirstEntry") var isFirstEntry: Bool = true
    @Published var onboardingStatus: OnboardingState = .words

    func switchState() {
        switch onboardingStatus {
        case .words:
            onboardingStatus = .comments
        case .comments:
            onboardingStatus = .rating
        case .rating:
            isFirstEntry = false
        }
    }
}

enum OnboardingState {
    case words, comments, rating
}
