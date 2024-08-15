//
//  CardModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import Foundation

struct Card: Codable, Hashable {
    let word: String
    let partOfSpeach: String
    let transcription: String
    let description: String
    let usageExample: String
    let synonyms: String
}

struct CardWrapper: Codable {
    let cards: [Card]
}
