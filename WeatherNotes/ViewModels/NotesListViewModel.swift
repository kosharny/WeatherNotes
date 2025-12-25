//
//  NotesListViewModel.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation
import Combine

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []

    private let storage = NotesStorage()

    init() {
        notes = storage.load()
    }

    func addNote(text: String, weather: WeatherInfo) {
        let note = Note(
            id: UUID(),
            text: text,
            date: Date(),
            weather: weather
        )

        notes.insert(note, at: 0)
        storage.save(notes)
    }
}


