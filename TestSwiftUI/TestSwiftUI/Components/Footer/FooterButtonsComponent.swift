//
//  FooterButtonsComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    @Binding var items: [UIImage]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct FooterButtonsComponent: View {
    var card: Card
    @Binding var shareImage: [UIImage]
    @EnvironmentObject var footerManager: FooterManager
    var body: some View {
        HStack {
            Button(action: {
                footerManager.saveImageToGallery(shareImage[0])
            }, label: {
                Image(uiImage: .downloadIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())
            .padding(.leading, 16)

            Spacer()

            Button(action: {
                if footerManager.audioPlayer.isPlaying {
                    footerManager.stopSound()
                } else {
                    footerManager.playSoundForWord(word: card.word)
                }
            }, label: {
                Image(uiImage: footerManager.audioPlayer.isPlaying ? .listenFillIcon : .listenIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())

            Spacer()

            Button(action: {
                if footerManager.checkFavorites(word: card.word) {
                    footerManager.removeFromFavorites(word: card.word)
                } else {
                    footerManager.saveToFavorites(card: card)
                }
            }, label: {
                Image(uiImage: footerManager.checkFavorites(word: card.word) == true ? .saveFavoriteFillIcon : .saveFavoriteIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    return FooterButtonsComponent(card: Card(word: "word", partOfSpeach: "partOfSpeech", transcription: "transcription", description: "description", usageExample: "usageExample", synonyms: "synonyms"), shareImage: .constant([UIImage.img]))
        .environmentObject(FooterManager())
}
