//
//  NoteDetailsViewModel.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 25.12.2025.
//

import Foundation
import Combine

final class NoteDetailsViewModel: ObservableObject {
    let note: Note

    init(note: Note) {
        self.note = note
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: note.date)
    }

    var temperatureText: String {
        "\(Int(note.weather.temperature))°C"
    }

    var weatherIconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(note.weather.icon)@2x.png")
    }
}

