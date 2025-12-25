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
            List(vm.notes) { note in
                HStack {
                    VStack(alignment: .leading) {
                        Text(note.text).font(.headline)
                        Text(note.date.formatted()).font(.caption)
                    }

                    Spacer()

                    Text("\(Int(note.weather.temperature))°")
                    Image(systemName: "cloud.fill") 
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



#Preview {
    NotesListView()
}
