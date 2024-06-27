//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

@main
struct TestSwiftUIApp: App {
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            VocabularyView().environmentObject(mainViewModel)
        }
    }
}

