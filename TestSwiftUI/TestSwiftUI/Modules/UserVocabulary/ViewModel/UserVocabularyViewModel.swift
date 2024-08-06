//
//  UserVocabularyViewModel.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI
import CoreData
final class UserVocabularyViewModel: ObservableObject {
    @Published var favoriteCards: [Cards] = []

    func obtainData(moc: NSManagedObjectContext) {
        let cardFetchRequest: NSFetchRequest<Cards> = Cards.fetchRequest()

        do {
            favoriteCards = try moc.fetch(cardFetchRequest)
        } catch {
            print("Ошибка получения карточек: \(error.localizedDescription)")
        }
    }

    func removeFromFavorites(moc: NSManagedObjectContext, title: String) {
        let cardFetchRequest: NSFetchRequest<Cards> = Cards.fetchRequest()
        cardFetchRequest.predicate = NSPredicate(format: "title == %@", title as CVarArg)

        do {
            if let card = try moc.fetch(cardFetchRequest).first {
                moc.delete(card)
                try moc.save()
                obtainData(moc: moc)
            } else {
                print("Карточка с названием \(title) не найдена.")
            }
        } catch {
            print("Ошибка удаления карточки: \(error.localizedDescription)")
        }
    }

    func getSynonymsArray(synonymsArray: [Synonyms]) -> [String] {
        var result: [String] = []
        for synonym in synonymsArray {
            result.append(synonym.synonym ?? "")
        }
        return result
    }
}
