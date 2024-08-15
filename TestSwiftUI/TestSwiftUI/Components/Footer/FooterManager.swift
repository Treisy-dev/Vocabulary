//
//  FooterManager.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import PhotosUI
import SwiftUI
import AVFoundation

@MainActor
final class FooterManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @AppStorage("favorites") var favorites: [Card] = []
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

    func playSoundForWord(word: String) {
        configureAudioSession()
        Task {
            if let unwrapedSoundData = await AppWriteManager.shared.getSoundForWord(word: word) {
                do {
                    audioPlayer = try AVAudioPlayer(data: unwrapedSoundData)
                    audioPlayer.delegate = self
                    audioPlayer.prepareToPlay()
                    isPlaying = true
                    audioPlayer.play()
                } catch {
                    print("Ошибка воспроизведения аудио файла: \(error.localizedDescription)")
                }
            } else {
                print("Ошибка при получении данных для звука.")
            }
        }
    }

    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            DispatchQueue.main.async { [weak self] in
                self?.isPlaying = false
            }
            print("Аудиофайл завершил воспроизведение")
        }
    }

    func stopSound() {
        isPlaying = false
        audioPlayer.stop()
    }

    func checkFavorites(word: String) -> Bool {
        return favorites.contains(where: {$0.word == word})
    }

    func saveToFavorites(card: Card) {
        favorites.append(card)
        isWordSavedFavorite = true
    }

    func removeFromFavorites(word: String) {
        favorites.removeAll(where: {$0.word == word})
        isWordSavedFavorite = true
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

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
        }
    }
}
