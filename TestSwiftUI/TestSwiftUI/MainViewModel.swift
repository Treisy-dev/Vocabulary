//
//  MainViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

final class MainViewModel: NSObject, ObservableObject {
    let mainModel: MainModel = MainModel()
    var decodedCards: [Card] = []
    @Published var cards: [Card] = []
    var currentCardIndex: Int = 0

    override init() {
        super.init()
        decodedCards = obtainDecodeData()
        updateCardDataBy10()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoadNewCards), name: .loadNewCards, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func handleLoadNewCards() {
        updateCardDataBy10()
    }

    func updateCardDataBy10() {
        for cardIndex in currentCardIndex..<decodedCards.count {
            var card = decodedCards[cardIndex]
            mainModel.getWordInfo(for: card.title) { [weak self] result in
                switch result {
                case .success(let success):
                    card.info = success.first
                    self?.cards.append(card)
                case .failure(let error):
                    print("error with obtain card data: \(error.localizedDescription)")
                }
            }
        }
        currentCardIndex = min(decodedCards.count, currentCardIndex + 10)
    }

    private func obtainDecodeData() -> [Card] {
        guard let json = NSDataAsset(name: "example") else {
            print("Json файл не найден в Assets")
            return []
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(CardWrapper.self, from: json.data)
            return result.cards
        } catch {
            print("Ошибка декодирования JSON: \(error.localizedDescription)")
        }

        return []
    }
}
