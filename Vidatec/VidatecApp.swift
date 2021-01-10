//
//  VidatecApp.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 09/01/2021.
//

import SwiftUI

@main
struct VidatecApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.commands {
            SidebarCommands()
        }
    }
}
