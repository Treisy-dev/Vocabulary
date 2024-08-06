//
//  CardComponent.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI

struct CardComponent: View {
    var cardData: Card
    @EnvironmentObject var footerManager: FooterManager

    var body: some View {
        ScrollView {
            ZStack {
                Image(uiImage: UIImage(named: cardData.imageName) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minHeight: 478)
            }
            VStack {
                Spacer()

                VStack(alignment: .center, spacing: 4) {
                    Text(cardData.title)
                        .foregroundColor(.text)
                        .font(Font.CharisSILR)

                    Text(cardData.info?.meanings.first?.partOfSpeech ?? "Untitled")
                        .foregroundColor(.text)
                        .font(.system(size: 12))
                        .italic()

                    Text(cardData.info?.phonetic ?? "Untitled")
                        .foregroundColor(.text)
                        .font(.system(size: 16))
                }
                .frame(minWidth: 250, maxWidth: 295, minHeight: 80, maxHeight: 96)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.appYellow)
                        .shadow(radius: 4)
                }
                .padding(.top, -60)

                Text(cardData.info?.meanings.first?.definitions.first?.definition ?? "Untitled")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                    .padding()

                Text(cardData.exampleText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.text)
                    .font(.system(size: 16))
                    .italic()
                    .padding()

                HStack {
                    if let synonyms = cardData.info?.meanings.first?.synonyms.prefix(3) {
                        ForEach(synonyms, id: \.self) { attribute in
                            CardAttribute(text: attribute)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    CardComponent(cardData: Card(imageName: "img", title: "title", exampleText: "exampleText", info: WordInformation(phonetic: "dkdkdkd", phonetics: [CardAudio(audio: "")], meanings: [MeaningInformation(partOfSpeech: "partOfSpeech", definitions: [DefinitionModel(definition: "definition")], synonyms: ["synonym1", "synonym2"])])))
        .environmentObject(FooterManager())
}
