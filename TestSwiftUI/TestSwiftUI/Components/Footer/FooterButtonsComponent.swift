//
//  FooterButtonsComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct FooterButtonsComponent: View {
    var card: Card
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var footerManager: FooterManager
    var body: some View {
        HStack {
            Button(action: {
                footerManager.saveImageToGallery(UIImage(named: card.imageName))
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
                    if let url = URL(string: card.info?.phonetics.first?.audio ?? "") {
                        footerManager.playSound(url: url)
                    }
                }
            }, label: {
                Image(uiImage: footerManager.audioPlayer.isPlaying ? .listenFillIcon : .listenIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())

            Spacer()

            Button(action: {
                if footerManager.checkFavorites(moc: moc, title: card.title) {
                    footerManager.removeFromFavorites(moc: moc, title: card.title)
                } else {
                    footerManager.saveToFavorites(moc: moc, card: card)
                }
            }, label: {
                Image(uiImage: footerManager.checkFavorites(moc: moc, title: card.title) == true ? .saveFavoriteFillIcon : .saveFavoriteIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    FooterButtonsComponent(card: Card(imageName: "img", title: "title", exampleText: "exampleText", info: WordInformation(phonetic: "dkdkdkd", phonetics: [CardAudio(audio: "")], meanings: [MeaningInformation(partOfSpeech: "partOfSpeech", definitions: [DefinitionModel(definition: "definition")], synonyms: ["synonym1", "synonym2"])])))
        .environmentObject(FooterManager())
}
