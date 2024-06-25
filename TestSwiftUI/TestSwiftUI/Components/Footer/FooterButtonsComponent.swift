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
    var image: UIImage
    var audioName: String
    var wordId: String
    @EnvironmentObject var footerManager: FooterManager
    var body: some View {
        HStack {
            Button(action: {
                footerManager.saveImageToGallery(image)
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
                    footerManager.playSound(sound: audioName)
                }
            }, label: {
                Image(uiImage: footerManager.audioPlayer.isPlaying ? .listenFillIcon : .listenIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())

            Spacer()

            Button(action: {
                if footerManager.checkFavorites(id: wordId) {
                    footerManager.removeFromFavorites(id: wordId)
                } else {
                    footerManager.saveToFavorites(id: wordId)
                }
            }, label: {
                Image(uiImage: footerManager.checkFavorites(id: wordId) == true ? .saveFavoriteFillIcon : .saveFavoriteIcon)
                    .frame(width: 56, height: 56)
                    .background(Color.button.opacity(0.2))
            })
            .clipShape(Circle())
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    @State var image: UIImage = UIImage.img
    @State var wordId: String = "1"
    @State var audioName: String = "exampleSound"

    return FooterButtonsComponent(image: image, audioName: audioName, wordId: wordId)
        .environmentObject(FooterManager())
}
