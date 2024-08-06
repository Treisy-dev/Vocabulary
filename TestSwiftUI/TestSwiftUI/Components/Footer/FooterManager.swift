//
//  FooterManager.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import PhotosUI
import SwiftUI
import AVFoundation
import CoreData

final class FooterManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isPlaying: Bool = false
    @Published var isPhotoSaved: Bool = false
    @Published var isWordShared: Bool = false
    @Published var isWordSavedFavorite: Bool = false
    @Published var isWordsEnd: Bool = false
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    func dropStates() {
        isPlaying = false
        isPhotoSaved = false
        isWordShared = false
        isWordSavedFavorite = false
        isWordsEnd = false
    }

    func playSound(url: URL) {
        let downloadTask = URLSession.shared.downloadTask(with: url) { [weak self] (localURL, response, error) in
            if let localURL = localURL {
                do {
                    self?.audioPlayer = try AVAudioPlayer(contentsOf: localURL)
                    self?.audioPlayer.delegate = self
                    self?.audioPlayer.prepareToPlay()
                    self?.isPlaying = true
                    self?.audioPlayer.play()
                } catch {
                    print("Ошибка воспроизведения аудио файла: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Ошибка загрузки аудио файла: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            print("Аудиофайл завершил воспроизведение")
        }
    }

    func stopSound() {
        isPlaying = false
        audioPlayer.stop()
    }

    func checkFavorites(moc: NSManagedObjectContext, title: String) -> Bool {
        let cardFetchRequest: NSFetchRequest<Cards> = Cards.fetchRequest()
        cardFetchRequest.predicate = NSPredicate(format: "title == %@", title as CVarArg)

        let card = try? moc.fetch(cardFetchRequest).first

        return card != nil
    }

    func saveToFavorites(moc: NSManagedObjectContext, card: Card) {
        let newCard = Cards(context: moc)
        newCard.audioURL = card.info?.phonetics.first?.audio
        newCard.title = card.title
        newCard.exampleUsage = card.exampleText
        newCard.imageName = card.imageName
        newCard.partOfSpeech = card.info?.meanings.first?.partOfSpeech
        newCard.transcrtiption = card.info?.phonetic
        newCard.definition = card.info?.meanings.first?.definitions.first?.definition
        if let synonyms = card.info?.meanings.first?.synonyms {
            for synonym in synonyms {
                let newSynonym = Synonyms(context: moc)
                newSynonym.synonym = synonym
                newCard.addToSynonyms(newSynonym)
            }
        }
        do {
            try moc.save()
            isWordSavedFavorite = true
        } catch {
            print("Ошибка при окончательном сохранении: \(error)")
        }
    }

    func removeFromFavorites(moc: NSManagedObjectContext, title: String) {
        let cardFetchRequest: NSFetchRequest<Cards> = Cards.fetchRequest()
        cardFetchRequest.predicate = NSPredicate(format: "title == %@", title as CVarArg)

        do {
            if let card = try moc.fetch(cardFetchRequest).first {
                moc.delete(card)
                try moc.save()
                isWordSavedFavorite = true
            } else {
                print("Карточка с названием \(title) не найдена.")
            }
        } catch {
            print("Ошибка удаления карточки: \(error.localizedDescription)")
        }
    }

    func saveImageToGallery(_ image: UIImage?) {
        guard let image = image else { return }

        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                if status == .authorized {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    DispatchQueue.main.async {
                        self.isPhotoSaved = true
                    }
                } else {
                    print("Доступ к галерее запрещен")
                }
            }
        }
    }

    func createShareItems(image: UIImage?, word: String, transcription: String) -> [Any] {
        var items: [Any] = []
        if let image = image {
            items.append(image)
        }
        items.append("\(word) - \(transcription)")
        return items
    }
}
