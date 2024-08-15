//
//  MainViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

final class MainViewModel: NSObject, ObservableObject {
    @Published var cards: [Card] = []

    private let seedKey = "vocabularySeedKey"

    override init() {
        super.init()
        let seed = getOrCreateSeed()
        var generator = SeededGenerator(seed: seed)
        cards = obtainDecodeData().shuffled(using: &generator)
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

    private func getOrCreateSeed() -> UInt64 {
        if let existingSeed = UserDefaults.standard.object(forKey: seedKey) as? UInt64 {
            return existingSeed
        } else {
            let newSeed = UInt64(Date().timeIntervalSince1970)
            UserDefaults.standard.set(newSeed, forKey: seedKey)
            return newSeed
        }
    }
}

struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed
    }

    mutating func next() -> UInt64 {
        state = state &* 6364136223846793005 &+ 1
        let x = state
        let shift = UInt64((x >> 18) ^ x) >> 27
        let rotation = Int(x >> 59)
        return UInt64((shift >> rotation) | (shift << ((-rotation) & 31)))
    }
}
