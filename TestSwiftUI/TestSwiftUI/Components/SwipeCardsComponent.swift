//
//  SwipeCardsComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct SwipeCardsComponent: View {
    @State private var currentIndex: Int = 0
    @EnvironmentObject var viewModel: MainViewModel
    @GestureState private var dragState = DragState.inactive
    @State private var removalTransition = AnyTransition.move(edge: .trailing)
    @StateObject var footerManager: FooterManager = FooterManager()

    private let dragThreshold: CGFloat = 80.0

    var body: some View {
        VStack {
            if viewModel.cards.indices.contains(currentIndex) {
                CardComponent(cardData: viewModel.cards[currentIndex])
                    .zIndex(0.5)
                    .offset(x: self.dragState.translation.width, y: 0)
                    .animation(.interpolatingSpring(stiffness: 180, damping: 100), value: dragState.translation.width)
                    .gesture(self.dragGesture())
                    .transition(self.removalTransition)
                    .environmentObject(footerManager)
            }
            FooterButtonsComponent(
                image: UIImage(named: viewModel.cards[currentIndex].imageName) ?? .img,
                audioName: viewModel.cards[currentIndex].soundName,
                wordId: viewModel.cards[currentIndex].id
            )
            .frame(height: 64)
            .environmentObject(footerManager)
        }
        .overlay(alignment: .top, content: { alertOverlay })
    }

    private var alertOverlay: some View {
        ZStack {
            if footerManager.isPhotoSaved {
                SavedAlertComponent(titleText: "The word is saved to your Photos")
                    .zIndex(0.6)
                    .padding(.horizontal, 10)
                    .environmentObject(footerManager)
            }

            if footerManager.isWordShared {
                SavedAlertComponent(titleText: "You shared a word")
                    .zIndex(0.6)
                    .padding(.horizontal, 10)
                    .environmentObject(footerManager)
            }

            if footerManager.isWordSavedFavorite {
                if footerManager.checkFavorites(id: viewModel.cards[currentIndex].id) {
                    SavedAlertComponent(titleText: "The word is saved to My Vocabulary", description: "You can find your words in My Vocabulary")
                        .zIndex(0.6)
                        .padding(.horizontal, 10)
                        .environmentObject(footerManager)
                } else {
                    SavedAlertComponent(titleText: "The word is deleted from My Vocabulary")
                        .zIndex(0.6)
                        .padding(.horizontal, 10)
                        .environmentObject(footerManager)
                }
            }

            if footerManager.isWordsEnd {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .zIndex(0.7)

                WordsEndComponent()
                    .zIndex(0.8)
                    .environmentObject(footerManager)
            }
        }
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .updating($dragState) { value, state, _ in
                state = .dragging(translation: value.translation)
            }
            .onEnded { value in
                if abs(value.translation.width) > self.dragThreshold {
                    let direction: Direction = value.translation.width > 0 ? .left : .right
                    self.changeCard(direction: direction)
                }
            }
    }

    private func changeCard(direction: Direction) {
        footerManager.dropStates()
        if direction == .right {
            let nextIndex = currentIndex + 1
            if nextIndex < viewModel.cards.count {
                currentIndex = nextIndex
                removalTransition = .move(edge: .leading)
            } else {
                footerManager.isWordsEnd = true
            }
        } else if direction == .left {
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                currentIndex = previousIndex
                removalTransition = .move(edge: .trailing)
            }
        }
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

enum Direction {
    case left
    case right
}

#Preview {
    SwipeCardsComponent()
        .environmentObject(MainViewModel())
}
