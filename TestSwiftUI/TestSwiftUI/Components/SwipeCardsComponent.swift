//
//  SwipeCardsComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct SwipeCardsComponent: View {
    @AppStorage("currentIndex") var currentIndex: Int = 0
    @State var cards: [Card]
    @State var currentImage: UIImage? = nil
    @GestureState private var dragState = DragState.inactive
    @State private var removalTransition = AnyTransition.move(edge: .trailing)
    @State var isShareTapped: Bool = false
    @StateObject var footerManager: FooterManager = FooterManager()
    @Environment(\.dismiss) var dismiss
    @State var isRatingShow: Bool = false
    private let dragThreshold: CGFloat = 80.0

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(uiImage: .closeIcone)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding()
                            .background(Color.appLight.opacity(0.4))
                    }
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())

                    Spacer()

                    Button(action: {
                        self.isShareTapped = true
                    }) {
                        Image(uiImage: .shareIcon)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding()
                            .background(Color.appLight.opacity(0.4))
                    }
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    .sheet(isPresented: $isShareTapped, content: {
                        ShareSheet(items: [currentImage ?? .img, "\(cards[currentIndex].word) - \(cards[currentIndex].transcription)", ])
                            .onDisappear {
                                footerManager.isWordShared = true
                            }
                    })
                }
                .zIndex(0.6)
                .padding(.horizontal)

                if cards.indices.contains(currentIndex) {
                    CardComponent(cardData: cards[currentIndex], cardImage: $currentImage)
                        .zIndex(0.5)
                        .offset(x: self.dragState.translation.width, y: 0)
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100), value: dragState.translation.width)
                        .gesture(self.dragGesture())
                        .transition(self.removalTransition)
                        .environmentObject(footerManager)
                }
            }

            FooterButtonsComponent(card: cards[currentIndex], cardImage: $currentImage)
            .frame(height: 64)
            .environmentObject(footerManager)
        }
        .onChange(of: currentIndex, perform: { value in
            loadImageForWord(word: cards[value].word)
        })
        .onAppear {
            loadImageForWord(word: cards[currentIndex].word)
        }
        .toolbar(.hidden)
        .overlay(alignment: .top, content: { alertOverlay })
        .alert("Please leave a review", isPresented: $isRatingShow) {
            Button("Go to the AppStore", role: .cancel) {
                print("appstore")
            }
        } message: {
            Text("Positive feedback gives us serious motivation to improve")
        }
    }

    private var alertOverlay: some View {
        ZStack {
            if footerManager.isPhotoSaved {
                SavedAlertComponent(titleText: "The word is saved to your Photos")
                    .zIndex(0.6)
                    .padding(.horizontal, 10)
            }

            if footerManager.isWordShared {
                SavedAlertComponent(titleText: "You shared a word")
                    .zIndex(0.6)
                    .padding(.horizontal, 10)
            }

            if footerManager.isWordSavedFavorite {
                if footerManager.checkFavorites(word: cards[currentIndex].word) {
                    SavedAlertComponent(titleText: "The word is saved to My Vocabulary", description: "You can find your words in My Vocabulary")
                        .zIndex(0.6)
                        .padding(.horizontal, 10)
                } else {
                    SavedAlertComponent(titleText: "The word is deleted from My Vocabulary")
                        .zIndex(0.6)
                        .padding(.horizontal, 10)
                }
            }

            if footerManager.isWordsEnd {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .zIndex(0.7)

                WordsEndComponent()
                    .zIndex(0.8)
            }
        }
        .environmentObject(footerManager)
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .updating($dragState) { value, state, _ in
                if cards.count > 1 {
                    state = .dragging(translation: value.translation)
                }
            }
            .onEnded { value in
                if cards.count > 1 && abs(value.translation.width) > self.dragThreshold {
                    let direction: Direction = value.translation.width > 0 ? .left : .right
                    self.changeCard(direction: direction)
                }
            }
    }

    private func changeCard(direction: Direction) {
        if cards.count <= 1 {
            return
        }

        footerManager.dropStates()

        if direction == .right {
            let nextIndex = currentIndex + 1
            if nextIndex < cards.count {
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
        isRatingShow = (currentIndex + 1) % 4 == 0
    }

    private func openAppStore() {
        let appStoreUrl = "https://apps.apple.com/app/id\(ConfigData.appId)"

        if let url = URL(string: appStoreUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Невозможно создать URL")
        }
    }

    private func loadImageForWord(word: String) {
        Task {
            let fetchedImage = await AppWriteManager.shared.getImageForWord(word: word)
            currentImage = fetchedImage
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
    let mainVM = MainViewModel()
    return SwipeCardsComponent(cards: mainVM.cards)
}
