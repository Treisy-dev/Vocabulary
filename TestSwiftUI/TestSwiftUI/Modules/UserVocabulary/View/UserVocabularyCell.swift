//
//  UserVocabularyCell.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

struct UserVocabularyCell: View {
    @EnvironmentObject var viewModel: UserVocabularyViewModel
    @State private var showAlert = false
    var card: Card

    var alert: Alert {
        Alert(
            title: Text("Do you want to delete the word from My Vocabulary?"),
            message: Text("It will be impossible to restore it"),
            primaryButton: .destructive(Text("Yes")) {
                viewModel.removeFromFavorites(id: card.id)
            },
            secondaryButton: .cancel()
        )
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(card.imageName)
                .resizable()
                .frame(width: 70, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading) {
                Text(card.title)
                    .font(.system(size: 16))
                Text(card.transcrtiption)
                    .font(.system(size: 12))
                    .padding(.bottom)
                Text(card.description)
                    .font(.system(size: 12))
            }
            .background {
                NavigationLink(destination: SwipeCardsComponent(cards: [card])) {
                    EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(0)
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

#Preview {
    UserVocabularyCell(card: Card(id: "1", imageName: "img", title: "title", type: "type", transcrtiption: "[transcrtiption]", description: "description", soundName: "example", exampleText: "exampleText", atributes: ["atributes1", "atributes2"]))
}
