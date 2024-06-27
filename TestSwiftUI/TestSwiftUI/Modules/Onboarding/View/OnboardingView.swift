//
//  OnboardingView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State var titleText: String = "Remember words effortlessly"
    @State var descriptionText: String = "Learn new words every day and expand your vocabulary"
    var body: some View {
        ZStack(alignment: .top) {
            switch viewModel.onboardingStatus {
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
                        titleText = "Leave your opinion about the app"
                        descriptionText = "Tell us about your experience with the app and help us make it better"
                    }
            case .rating:
                Image(uiImage: .onboardingRating)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 44)
                    .onAppear {
                        titleText = "Master your words for fluency"
                        descriptionText = "This will help you enhance your ability to memorize the words effectively"
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
}


#Preview {
    OnboardingView(titleText: "Remember words effortlessly", descriptionText: "Learn new words every day and expand your vocabulary")
}

