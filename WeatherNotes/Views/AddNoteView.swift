//
//  AddNoteView.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import SwiftUI

struct AddNoteView: View {
    
    @ObservedObject var vm: NotesListViewModel
    @State private var text = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
    @Binding var showAddNote: Bool
    
    let weatherService = WeatherService()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter text...", text: $text, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Spacer()
                
                Button("Save") {
                    Task {
                        await save()
                    }
                }
                .disabled(text.isEmpty || isLoading)
            }
            .navigationTitle("New note")
            .alert("Error", isPresented: $showErrorAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func save() async {
        isLoading = true
        do {
            let weather = try await weatherService.fetchCurrentWeather()
            
            let newNote = Note(
                id: UUID(),
                text: text,
                date: .now,
                weather: weather
            )
            
            await MainActor.run {
                vm.add(note: newNote)
                isLoading = false
                showAddNote = false
            }
            // MARK: - UserDefaults
            //            vm.addNote(text: text, weather: weather)
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.showErrorAlert = true
                self.isLoading = false
            }
        }
        isLoading = false
    }
}
