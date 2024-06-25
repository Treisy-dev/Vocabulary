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
    @AppStorage("favorites") var favorites: Data = Data()
    @Published var isPlaying: Bool = false
    @Published var isPhotoSaved: Bool = false
    @Published var isWordShared: Bool = false
    @Published var isWordSavedFavorite: Bool = false
    @Published var isWordsEnd: Bool = false
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()

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

    var storedArray: [String] {
        get {
            guard let decodedArray = try? JSONDecoder().decode([String].self, from: favorites) else {
                return []
            }
            return decodedArray
        }
        set {
            favorites = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }

    func checkFavorites(id: String) -> Bool {
        return storedArray.contains(where: {$0 == id})
    }

    func saveToFavorites(id: String) {
        var newArray = storedArray
        newArray.append(id)
        storedArray = newArray
        isWordSavedFavorite = true
    }

    func removeFromFavorites(id: String) {
        var newArray = storedArray
        newArray.removeAll(where: {$0 == id})
        storedArray = newArray
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
