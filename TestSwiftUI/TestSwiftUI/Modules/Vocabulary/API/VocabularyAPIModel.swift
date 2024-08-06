//
//  VocabularyModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 06.08.2024.
//

import Foundation

struct WordInformation: Codable {
    let phonetic: String?
    let phonetics: [CardAudio]
    let meanings: [MeaningInformation]
}

struct MeaningInformation: Codable {
    let partOfSpeech: String
    let definitions: [DefinitionModel]
    let synonyms: [String]
}

struct DefinitionModel: Codable {
    let definition: String
//    let example: String?
}

struct CardAudio: Codable {
    let audio: String?
}
