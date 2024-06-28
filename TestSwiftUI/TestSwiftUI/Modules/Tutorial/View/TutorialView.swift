//
//  TutorialView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct TutorialView: View {
    @StateObject var viewModel = TutorialViewModel()
    @State var titleText: String = "To effectively learn new words, we suggest practicing daily"
    @State private var currentCard = 0

    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationBarComponent(title: "Tutorial")
            TutorialDescriptionComponent(titleText: titleText)

            switch viewModel.tutorialState {
            case .myVocabulary:
                Image(uiImage: .tutorialMyVocabulary)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 375, maxHeight: 344)
            case .settings:
                Image(uiImage: .tutorialSettings)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 375, maxHeight: 344)
                    .onAppear {
                        titleText = "Turn on notifications so you don't miss new words"
                    }
            case .favourites:
                Image(uiImage: .tutorialFavourites)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 375, maxHeight: 344)
                    .onAppear {
                        titleText = "Add words you don't know and want to memorize to My Vocabulary. So you can access them quickly"
                    }
            }

            SwipeIndicatorComponent(totalPoints: 3, currentPoint: $currentCard)
                .animation(.easeInOut(duration: 0.3), value: currentCard)

            Spacer()

            Button(action: {
                viewModel.switchState()
                withAnimation {
                    currentCard = (currentCard + 1) % 3
                }
            }, label: {
                Text("Next")
                    .foregroundStyle(Color.elements)
                    .frame(minWidth: 200, maxWidth: 215, minHeight: 35, maxHeight: 40)
            })
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(Color.appYellow)
            }
            .padding(.bottom, 16)
        }
        .background {
            Color.appLight
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TutorialView()
}
