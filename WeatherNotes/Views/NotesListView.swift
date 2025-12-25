//
//  NotesListView.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import SwiftUI

struct NotesListView: View {
    
    @StateObject private var vm = NotesListViewModel()
    @State private var showAddNote = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.notes) { note in
                    NavigationLink {
                        NoteDetailsView(
                            vm: NoteDetailsViewModel(note: note)
                        )
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(note.text).font(.headline)
                                Text(note.date.formatted()).font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(Int(note.weather.temperature))°")
                            WeatherIconView(icon: note.weather.icon)
                                .frame(width: 32, height: 32)
                        }
                    }
                }
                .onDelete { indexSet in
                    vm.delete(at: indexSet)
                    // MARK: - UserDefaults
                    //                    vm.deleteNotes(at: indexSet)
                }
            }
            .navigationTitle("Weather Notes")
            .toolbar {
                Button {
                    showAddNote = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddNote) {
                AddNoteView(vm: vm, showAddNote: $showAddNote)
            }
        }
    }
}

struct WeatherIconView: View {
    let icon: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        ) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    NotesListView()
}
