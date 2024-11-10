//
//  DigitalDetoxApp.swift
//  DigitalDetox
//
//  Created by George on 2024/11/8.
//

import SwiftUI

@main
struct DigitalDetoxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
