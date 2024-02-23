//
//  PokeBookApp.swift
//  PokeBook
//
//  Created by d해 on 2023/03/20.
//

import SwiftUI

@main
struct PokeBookApp: App {
    init() {
        ServiceLocator.shared.registerPokeRepo(repo: RealPokeRepository())
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabScreen()
                .environment(\.managedObjectContext,
                              PersistenceController.shared.container.viewContext)
        }
    }
}
