//
//  NoteDetailsView.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 25.12.2025.
//

import SwiftUI

struct NoteDetailsView: View {
    @StateObject var vm: NoteDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                Text(vm.note.text)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(vm.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Divider()

                VStack(spacing: 12) {

                    if let url = vm.weatherIconURL {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                    }

                    Text(vm.temperatureText)
                        .font(.largeTitle.bold())

                    Text(vm.note.weather.description.capitalized)
                        .font(.headline)

                    Text(vm.note.weather.city)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Note Details")
    }
}

