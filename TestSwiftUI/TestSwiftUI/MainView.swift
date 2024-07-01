//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFirstEntry") var isFirstEntry: Bool = true

    var body: some View {
        NavigationStack {
            if !isFirstEntry {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    MainView()
}
