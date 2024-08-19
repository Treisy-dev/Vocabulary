//
//  VocabularyView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 27.06.2024.
//

import SwiftUI

struct VocabularyView: View {
    @AppStorage("isFirstOpen") var isFirstOpen: Bool = true
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        ZStack {
            VStack {
                SwipeCardsComponent(cards: mainViewModel.cards, isDetailScreen: false)
            }
            .blur(radius: isFirstOpen ? 5 : 0)
            if isFirstOpen {
                HintComponent()
            }
        }
        .onAppear {
            PushNotificationManager.shared.requestNotificationAuthorization(completion: { granded in })
        }
        .background {
            Color.appLight
                .ignoresSafeArea()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    VocabularyView().environmentObject(MainViewModel())
}
