//
//  CardModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import Foundation

struct Card: Codable {
//    let id: String
    let imageName: String
    let title: String
//    let type: String
//    let transcrtiption: String
//    let description: String
//    let soundName: String
    let exampleText: String
//    let atributes: [String]
    var info: WordInformation?
}

struct CardWrapper: Codable {
    let cards: [Card]
}
