//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFirstOpen") var isFirstOpen: Bool = true
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
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
    MainView()
}
