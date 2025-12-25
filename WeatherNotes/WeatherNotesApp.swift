//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import SwiftUI

@main
struct WeatherNotesApp: App {
    
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NotesListView()
                .environment(\.managedObjectContext, persistence.context)
        }
    }
}
