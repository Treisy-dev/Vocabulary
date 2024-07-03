//
//  UserVocabularyViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

final class UserVocabularyViewModel: ObservableObject {
    @AppStorage("favorites") var favorites: [String] = []
    var mainViewModel: MainViewModel?

    @Published var favoriteCards: [Card] = []

    func obtainData() {
        guard let mainViewModel = mainViewModel else { return }
        favoriteCards = mainViewModel.cards.filter { card in
            favorites.contains(card.id)
        }
    }

    func removeFromFavorites(id: String) {
        favorites.removeAll(where: {$0 == id})
        favoriteCards.removeAll(where: {$0.id == id})
    }
}
