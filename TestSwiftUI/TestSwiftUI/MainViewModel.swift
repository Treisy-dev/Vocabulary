//
//  MainViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

final class MainViewModel: NSObject, ObservableObject {
    var cards: [Card] = []

    override init() {
        super.init()
        cards = obtainDecodeData()
    }

    func obtainDecodeData() -> [Card] {
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
