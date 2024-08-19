//
//  AppWriteManager.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 15.08.2024.
//

import SwiftUI
import Appwrite

final class AppWriteManager {
    static var shared: AppWriteManager = AppWriteManager()
    let client: Client
    let storage: Storage

    private init() {
        client = Client()
            .setEndpoint("https://backepp.com/v1")
            .setProject("66bda9e8000cd0ab7776")
            .setSelfSigned(true)
        storage = Storage(client)
    }

    func getSoundForWord(word: String) async -> Data? {
        let fileID = word.lowercased().replaceNonEnglishAlphabetsWithUTF8Codes()
        do {
            let buffer = try await storage.getFileDownload(bucketId: "sounds", fileId: fileID)
            return Data(buffer: buffer)
        } catch {
            print("Error with download sound \(error)")
            return nil
        }
    }

    func getImageForWord(word: String) async -> UIImage? {
        let fileID = word.lowercased().replaceNonEnglishAlphabetsWithUTF8Codes()
        do {
            let buffer = try await storage.getFileDownload(bucketId: "images", fileId: fileID)

            let data = Data(buffer: buffer)

            if let image = UIImage(data: data) {
                return image
            } else {
                print("Error: Could not convert data to UIImage")
                return nil
            }
        } catch {
            print("Error with download image: \(error)")
            return nil
        }
    }
}

private extension String {
    func replaceNonEnglishAlphabetsWithUTF8Codes() -> String {
        var result = ""
        for char in self.unicodeScalars {
            if !(char >= "\u{0061}" && char <= "\u{007A}") &&
               !(char >= "\u{0041}" && char <= "\u{005A}") {
                // Convert non-English alphabet characters to their UTF-8 codes
                let utf8Code = char.utf8.map(String.init).joined()
                result.append(utf8Code)
            } else {
                result.append(String(char))
            }
        }
        return result
    }
}
