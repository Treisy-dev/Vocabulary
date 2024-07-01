//
//  UserVocabularyViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

final class UserVocabularyViewModel: ObservableObject {
    @AppStorage("favorites") var favorites: Data = Data()
    var mainViewModel: MainViewModel?

    var storedArray: [String] {
        get {
            guard let decodedArray = try? JSONDecoder().decode([String].self, from: favorites) else {
                return []
            }
            return decodedArray
        }
        set {
            favorites = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }

    @Published var favoriteCards: [Card] = []

    func obtainData() {
        guard let mainViewModel = mainViewModel else { return }
        favoriteCards = mainViewModel.cards.filter { card in
            storedArray.contains(card.id)
        }
    }

    func removeFromFavorites(id: String) {
        var newArray = storedArray
        newArray.removeAll(where: {$0 == id})
        storedArray = newArray
        favoriteCards.removeAll(where: {$0.id == id})
    }
}
