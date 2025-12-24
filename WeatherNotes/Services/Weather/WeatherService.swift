//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchCurrentWeather() async throws -> WeatherInfo
}

final class WeatherService: WeatherServiceProtocol {

    private let apiKey = "47feaf3bcfa4f338b3cceb2f8b075792"
    private let city = "Kyiv"
    
    func fetchCurrentWeather() async throws -> WeatherInfo {
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=en"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let dto = try JSONDecoder().decode(OpenWeatherDTO.self, from: data)

        return WeatherInfo(
            temperature: dto.main.temp,
            description: dto.weather.first?.description ?? "",
            icon: dto.weather.first?.icon ?? "",
            city: dto.name
        )
    }
}
