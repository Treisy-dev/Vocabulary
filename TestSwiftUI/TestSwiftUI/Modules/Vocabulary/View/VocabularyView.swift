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
                SwipeCardsComponent().environmentObject(mainViewModel)
            }
            .blur(radius: isFirstOpen ? 5 : 0)
            if isFirstOpen {
                HintComponent()
            }
        }
    }
}

#Preview {
    VocabularyView().environmentObject(MainViewModel())
}
