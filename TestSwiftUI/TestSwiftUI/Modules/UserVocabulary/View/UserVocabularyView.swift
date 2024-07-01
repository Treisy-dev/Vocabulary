//
//  UserVocabularyView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 01.07.2024.
//

import SwiftUI

struct UserVocabularyView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel: UserVocabularyViewModel = UserVocabularyViewModel()

    var body: some View {
        VStack {
            CustomNavigationBarComponent(title: "My Vocabulary")
            if viewModel.favoriteCards.count == 0 {
                VStack {
                    VStack(spacing: 10) {
                        Text("You don't have any words yet")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                        Text("Tap the bookmark to add words to your vocabulary")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 16))
                            .lineLimit(2)
                    }
                    .frame(maxWidth: 343, maxHeight: 124)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.alert)
                    }
                    .padding(.bottom, 26)
                    Image(uiImage: .userVocabHint)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 344)
                }
            } else {
                List(viewModel.favoriteCards, id: \.id) { card in
                    UserVocabularyCell(card: card)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .environmentObject(viewModel)
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Spacer()
        }
        .onAppear {
            if viewModel.mainViewModel == nil {
                viewModel.mainViewModel = mainViewModel
            }
            viewModel.obtainData()
        }
        .background{
            Color.appLight
                .ignoresSafeArea(.all)
        }
        .toolbar(.hidden)
    }
}

#Preview {
    UserVocabularyView().environmentObject(MainViewModel())
}
