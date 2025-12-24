//
//  Note.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let weather: WeatherInfo
}

struct WeatherInfo: Codable {
    let temperature: Double
    let description: String
    let icon: String
    let city: String
}
