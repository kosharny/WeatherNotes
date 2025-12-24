//
//  OpenWeatherDTO.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation

struct OpenWeatherDTO: Codable {
    struct Main: Codable { let temp: Double }
    struct Weather: Codable { let description: String; let icon: String }

    let main: Main
    let weather: [Weather]
    let name: String
}
