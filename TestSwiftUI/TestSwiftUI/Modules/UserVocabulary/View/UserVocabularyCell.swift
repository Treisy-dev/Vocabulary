//
//  UserVocabularyCell.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

struct UserVocabularyCell: View {
    @EnvironmentObject var viewModel: UserVocabularyViewModel
    @Environment(\.managedObjectContext) var moc
    @State private var showAlert = false
    var card: Cards

    var alert: Alert {
        Alert(
            title: Text("Do you want to delete the word from My Vocabulary?"),
            message: Text("It will be impossible to restore it"),
            primaryButton: .destructive(Text("Yes")) {
                viewModel.removeFromFavorites(moc: moc, title: card.title ?? "")
            },
            secondaryButton: .cancel()
        )
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(card.imageName ?? "")
                .resizable()
                .frame(width: 70, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading) {
                Text(card.title ?? "")
                    .font(.system(size: 16))
                Text(card.transcrtiption ?? "")
                    .font(.system(size: 12))
                    .padding(.bottom)
                Text(card.definition ?? "")
                    .font(.system(size: 12))
            }
            .background {
                if let synonymsArray = card.synonyms?.allObjects as? [Synonyms] {
                    NavigationLink(destination: SwipeCardsComponent(cards: [Card(imageName: card.imageName ?? "", title: card.title ?? "", exampleText: card.exampleUsage ?? "", info: WordInformation(phonetic: "dkdkdkd", phonetics: [CardAudio(audio: card.audioURL)], meanings: [MeaningInformation(partOfSpeech: card.partOfSpeech ?? "", definitions: [DefinitionModel(definition: card.definition ?? "")], synonyms: viewModel.getSynonymsArray(synonymsArray: synonymsArray))]))])) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {
                showAlert = true
            }, label: {
                Image(systemName: "trash")
                    .tint(Color.black)
                    .frame(width: 20, height: 20)
                    .padding(6)
                    .background(Circle().fill(Color.appYellow))
            })
            .frame(width: 20, height: 20)
            .buttonStyle(PlainButtonStyle())
            .padding(8)
            .alert(isPresented: $showAlert, content: {
                alert
            })
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 104)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.appYellow, lineWidth: 2)
        }
    }
}

//#Preview {
//    UserVocabularyCell(card: Card(imageName: "img", title: "title", exampleText: "exampleText", info: WordInformation(phonetic: "dkdkdkd", phonetics: [CardAudio(audio: "")], meanings: [MeaningInformation(partOfSpeech: "partOfSpeech", definitions: [DefinitionModel(definition: "definition")], synonyms: ["synonym1", "synonym2"])])))
//}
