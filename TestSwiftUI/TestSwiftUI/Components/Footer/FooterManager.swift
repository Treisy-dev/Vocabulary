//
//  FooterManager.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import PhotosUI
import SwiftUI
import AVFoundation

final class FooterManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @AppStorage("favorites") var favorites: [String] = []
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

    func playSound(sound: String) {
        guard let asset = NSDataAsset(name: sound) else {
            print("Аудио файл не найден в Assets")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(data: asset.data)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            isPlaying = true
            audioPlayer.play()
        } catch {
            print("Ошибка воспроизведения аудио файла: \(error.localizedDescription)")
        }
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

    func checkFavorites(id: String) -> Bool {
        return favorites.contains(where: {$0 == id})
    }

    func saveToFavorites(id: String) {
        favorites.append(id)
        isWordSavedFavorite = true
    }

    func removeFromFavorites(id: String) {
        favorites.removeAll(where: {$0 == id})
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
}
