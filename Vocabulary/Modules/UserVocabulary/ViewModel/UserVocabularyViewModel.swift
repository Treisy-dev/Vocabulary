//
//  UserVocabularyViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

final class UserVocabularyViewModel: ObservableObject {
    @AppStorage("favorites") var favorites: [Card] = []

    func removeFromFavorites(word: String) {
        favorites.removeAll(where: {$0.word == word})
    }
}
