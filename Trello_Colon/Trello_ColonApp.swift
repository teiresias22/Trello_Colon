//
//  Trello_ColonApp.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/15.
//

import SwiftUI

@main
struct Trello_ColonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
