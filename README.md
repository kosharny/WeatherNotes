# WeatherNotes 🌤️📝

WeatherNotes is a sleek and functional iOS application built with SwiftUI that allows users to create personal notes that automatically capture current weather conditions. 

It demonstrates modern iOS development practices, including asynchronous networking, local persistence, and clean architecture.

## Features ✨

- **Smart Notes**: Create notes that automatically fetch and store current weather (temperature, description, city, and icons).
- **Multi-line Input**: A dynamic text field that expands as you type.
- **Local Persistence**: Full Core Data integration to save your thoughts and weather data offline.
- **Weather Integration**: Real-time data fetching from OpenWeather API.
- **Robust Error Handling**: Handles network issues, API errors, and invalid responses gracefully with user alerts.
- **Dark Mode Support**: Fully adapted for Light and Dark interface styles.

## Tech Stack 🛠️

- **Language**: Swift
- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Database**: Core Data / User Defaults 
- **Concurrency**: Swift Concurrency (Async/Await)
- **API**: [OpenWeatherMap API](https://openweathermap.org/api)

## Project Structure 📂

- `Models/`: Data structures and Core Data entities.
- `ViewModels/`: Business logic and data preparation for views.
- `Views/`: SwiftUI components and screens.
- `Services/`: Networking persistence logic.
- `Storage/`: Core Data and User Defaults persistence logic.
