//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 20.06.2024.
//

import SwiftUI

@main
struct TestSwiftUIApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            if dataController.isLoaded {
                MainView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } else {
                LaunchScreen()
            }
        }
    }
    
}

