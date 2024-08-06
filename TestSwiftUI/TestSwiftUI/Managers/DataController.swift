//
//  DataController.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 06.08.2024.
//

import CoreData
import Foundation

final class DataController: ObservableObject {
    let container: NSPersistentContainer
    @Published var isLoaded: Bool = false

    init() {
        container = NSPersistentContainer(name: "VacabularyCoreData")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            DispatchQueue.main.async {
                self.isLoaded = true
            }
        }
    }
}
