//
//  TutorialView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 28.06.2024.
//

import SwiftUI

struct TutorialView: View {
    @StateObject var viewModel = TutorialViewModel()
    @Environment(\.dismiss) var dismiss
    @State var titleText: String = "To effectively learn new words, we suggest practicing daily"
    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationBarComponent(title: "Tutorial")
            TutorialDescriptionComponent(titleText: $titleText)

            ZStack {
                switch viewModel.tutorialState {
                case .myVocabulary:
                    Image(uiImage: .tutorialMyVocabulary)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 375, maxHeight: 344)
                        .transition(.opacity)
                        .onAppear {
                            titleText = "To effectively learn new words, we suggest practicing daily"
                        }

                case .settings:
                    Image(uiImage: .tutorialSettings)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 375, maxHeight: 344)
                        .transition(.opacity)
                        .onAppear {
                            titleText = "Turn on notifications so you don't miss new words"
                        }

                case .favourites:
                    Image(uiImage: .tutorialFavourites)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 375, maxHeight: 344)
                        .transition(.opacity)
                        .onAppear {
                            titleText = "Add words you don't know and want to memorize to My Vocabulary. So you can access them quickly"
                        }
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.tutorialState)

            SwipeIndicatorComponent(totalPoints: 3, currentPoint: $viewModel.currentIndex)
                .animation(.easeInOut(duration: 0.3), value: viewModel.currentIndex)

            Spacer()

            Button(action: {
                viewModel.nextState()
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
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 0 {
                        viewModel.previousState()
                    } else {
                        viewModel.nextState()
                    }
                }
        )
        .background {
            Color.appLight
                .ignoresSafeArea()
        }
        .toolbar(.hidden)
        .onChange(of: viewModel.isTutorialFinished) { isFinished in
            if isFinished {
                dismiss()
            }
        }
    }
}

#Preview {
    TutorialView()
}
