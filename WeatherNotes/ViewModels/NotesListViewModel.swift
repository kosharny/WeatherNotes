//
//  NotesListViewModel.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation
import SwiftUI
import Combine
import CoreData

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []
    // MARK: - UserDefaults
    /*
     {
     didSet {
     storage.save(notes)
     }
     }
     */
    
    private let context = PersistenceController.shared.context
    //    private let storage = NotesStorage()
    
    init() {
        loadNotes()
        // MARK: - UserDefaults
        //        notes = storage.load()
    }
    
    func loadNotes() {
        let request = NoteEntity.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteEntity.date, ascending: false)]
        
        if let result = try? context.fetch(request) {
            notes = result.compactMap { entity in
                Note(
                    id: entity.id ?? UUID(),
                    text: entity.text ?? "",
                    date: entity.date ?? .now,
                    weather: WeatherInfo(
                        temperature: entity.temperature,
                        description: entity.descriptionText ?? "",
                        icon: entity.icon ?? "",
                        city: entity.city ?? ""
                    )
                )
            }
        }
    }
    
    func add(note: Note) {
        let entity = NoteEntity(context: context)
        
        entity.id = note.id
        entity.text = note.text
        entity.date = note.date
        entity.temperature = note.weather.temperature
        entity.descriptionText = note.weather.description
        entity.icon = note.weather.icon
        entity.city = note.weather.city
        
        PersistenceController.shared.save()
        loadNotes()
    }
    
    func delete(at offsets: IndexSet) {
        offsets
            .map { notes[$0].id }
            .forEach { id in
                if let object = fetchEntity(by: id) {
                    context.delete(object)
                }
            }
        
        PersistenceController.shared.save()
        loadNotes()
    }
    
    private func fetchEntity(by id: UUID) -> NoteEntity? {
        let request = NoteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return try? context.fetch(request).first
    }
    
    // MARK: - UserDefaults
    /*
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
     
     func deleteNotes(at offsets: IndexSet) {
     notes.remove(atOffsets: offsets)
     }
     */
}


