//
//  NotesStorage.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation

final class NotesStorage {
    private let key = "notes_storage"

    func load() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Note].self, from: data)) ?? []
    }

    func save(_ notes: [Note]) {
        let data = try? JSONEncoder().encode(notes)
        UserDefaults.standard.set(data, forKey: key)
    }
}
