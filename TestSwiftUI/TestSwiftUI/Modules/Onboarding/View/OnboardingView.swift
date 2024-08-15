//
//  OnboardingView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI
import StoreKit

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State var titleText: String = "Remember words \neffortlessly"
    @State var descriptionText: String = "Learn new words every day and expand your vocabulary"
    var body: some View {
        ZStack(alignment: .top) {
            switch viewModel.onboardingState {
            case .words:
                Image(uiImage: .onboardingWords)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 44)
            case .comments:
                Image(uiImage: .onboardingComments)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 343, maxHeight: 329)
                    .padding(.top, 99)
                    .onAppear {
                        titleText = "Leave your opinion about \nthe app"
                        descriptionText = "Tell us about your experience with the app and help us make it better"
                    }
            case .rating:
                Image(uiImage: .onboardingRating)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 44)
                    .onAppear {
                        titleText = "Master your words for \nfluency"
                        descriptionText = "This will help you enhance your ability to memorize the words effectively"
                        showReviewRequest()
                    }
            }

            VStack {
                Spacer()
                OnboardingFooter(titleText: $titleText, descriptionText: $descriptionText)
                    .environmentObject(viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image(uiImage: .onboardingBack)
                .resizable()
                .background {
                    Color.appLight
                }
        }
        .ignoresSafeArea(.all)
    }

    func showReviewRequest() {
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: window)
        }
    }
}


#Preview {
    OnboardingView(titleText: "Remember words \neffortlessly", descriptionText: "Learn new words every day and expand your vocabulary")
}

