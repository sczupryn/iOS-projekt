//
//  PrzepisyApp.swift
//  Przepisy
//
//  Created by student on 20/05/2025.
//

import SwiftUI

@main
struct PrzepisyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
