//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Maksim Kosharny on 24.12.2025.
//

import Foundation

enum WeatherError: LocalizedError {
    case noNetwork
    case badResponse
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "Check your internet connection."
        case .badResponse:
            return "The weather server is temporarily unavailable."
        case .invalidData:
            return "Error processing weather data."
        case .unknown(let error):
            return "An error occurred: \(error.localizedDescription)"
        }
    }
}

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
            throw WeatherError.badResponse
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherError.badResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let dto = try JSONDecoder().decode(OpenWeatherDTO.self, from: data)
                    
                    return WeatherInfo(
                        temperature: dto.main.temp,
                        description: dto.weather.first?.description ?? "",
                        icon: dto.weather.first?.icon ?? "",
                        city: dto.name
                    )
                } catch {
                    throw WeatherError.invalidData
                }
            case 401:
                print("Error: Invalid API key.")
                throw WeatherError.badResponse
            case 404:
                print("Error: City not found")
                throw WeatherError.badResponse
            default:
                throw WeatherError.badResponse
            }
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw WeatherError.noNetwork
            case .timedOut:
                throw WeatherError.noNetwork
            default:
                throw WeatherError.unknown(error)
            }
        } catch {
            throw WeatherError.unknown(error)
        }
    }
}
