//
//  PremierLeagueApp.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import SwiftUI

@main
struct PremierLeagueApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
