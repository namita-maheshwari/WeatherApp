# Weather App

## Basic Idea About the App
The **Weather App** is an iOS application that provides real-time weather information and a 5-day weather forecast for a specified city. It uses a weather API to fetch live weather data, including temperature, humidity, and conditions, and presents the information in a clean and user-friendly UI.

The app is built using Swift and follows the **MVVM architecture** to separate the business logic from the UI, making the app maintainable and testable.

## Features
- **Current Weather**: Displays the current temperature, humidity, and weather conditions for a given city.
- **5-Day Forecast**: Provides a 5-day forecast, showing the max/min temperature and weather conditions for each day.
- **Error Handling**: Displays error messages for invalid city input or API request failure.
- **Loading State**: Shows a loading indicator while fetching weather data from the API.

### Screenshots
![AppHomePage](https://github.com/user-attachments/assets/9fb2bdec-8f63-4d5a-919b-cec1b04c60d7)

![Place1-Forecast](https://github.com/user-attachments/assets/997c5f33-ec4a-4b4c-bef3-78508c0cb5a9)
![Place2-Forecast](https://github.com/user-attachments/assets/6264aaf2-775e-4239-9492-46213e378b92)

## App Architecture

### MVVM (Model-View-ViewModel)
The app is structured using the **MVVM architecture**, which separates the UI code from the business logic and data handling. This architecture promotes modularity, reusability, and testability. Here's the breakdown:

- **Model**: Represents the weather data structures (e.g., `WeatherResponse`, `ForecastResponse`).
- **View**: The UI components that display the weather data (e.g., `UILabel`, `UIStackView`).
- **ViewModel**: The middle layer between the Model and View. The `WeatherViewModel` handles API calls and formats the weather data for the View to present.

This architecture ensures the app is clean, scalable, and maintainable.

## iOS Requirements

### Tools and Technologies:
- **Xcode**: Version 14.0 or later.
- **Swift**: Version 5.7 or later.
- **iOS SDK**: Version 16.0 or later.

### Libraries and Frameworks
The app uses native iOS libraries:
- **UIKit**: To create the user interface.
- **URLSession**: For making API requests to fetch weather data.
- **Codable**: To decode the JSON responses from the weather API.
- **NSAttributedString**: For displaying formatted text in the weather view.

## Weather API Used

The app fetches weather data from the [WeatherAPI](https://www.weatherapi.com/). This API provides detailed real-time weather information and a multi-day forecast for cities worldwide.

### Example API Response:
```json
{
"location": {
"name": "Hapur",
"region": "Uttar Pradesh",
"country": "India",
"lat": 28.7438,
"lon": 77.7755,
"tz_id": "Asia/Kolkata",
"localtime_epoch": 1696153200,
"localtime": "2024-10-01 12:00"
},
"current": {
"last_updated": "2024-10-01 12:00",
"temp_c": 30.0,
"is_day": 1,
"condition": {
"text": "Sunny",
"icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
"code": 1000
},
"wind_mph": 5.1,
"humidity": 50
},
"forecast": {
"forecastday": []
}
}
```

## App Structure

- **WeatherViewModel.swift**: Contains the logic to fetch weather data and format it for display.
- **WeatherViewController.swift**: The main controller responsible for presenting the weather information.
- **WeatherService.swift**: Manages the API requests and parses the response data.
- **Weather.swift**: Contains the data models like `WeatherResponse`, `ForecastResponse`, etc., used to map the JSON response.

## Setup and Installation

### Steps to Run the App:

1. **Clone the Repository**:
```bash
git clone https://github.com/your-repo/weather-app.git
cd weather-app
```

2. **Open in Xcode**:
Open the project in Xcode by navigating to the `.xcodeproj` file and opening it.

3. **Install Dependencies**:
Since there are no third-party dependencies, you can directly run the project after opening it in Xcode.

4. **Replace API Key**:
- Replace the placeholder API key in `WeatherService.swift` with your own API key from the weather API provider (e.g., WeatherAPI).
- Example:
```swift
let apiKey = "YOUR_API_KEY"
```

5. **Build and Run**:
- Choose an iOS simulator or connected device.
- Press `Cmd + R` to build and run the app.

## Testing

Unit tests are written using **XCTest** to validate the functionality of `WeatherViewModel`. The tests ensure the ViewModel formats weather data correctly for display, handles errors, and responds to API calls appropriately.

### How to Run Tests:
1. Open Xcode and select the `WeatherApp` scheme.
2. Press `Cmd + U` to run the tests or go to **Product > Test**.

### Code Coverage
Code coverage is used to measure the percentage of code tested by the unit tests. To generate code coverage reports:

1. Enable "Code Coverage" in the Build Settings of your test target in Xcode.
2. Run the tests (`Command + U`).
3. View the coverage report in the report navigator under the "Coverage" tab.

- **Attachements**:
<img width="1415" alt="CodeCoverage" src="https://github.com/user-attachments/assets/e710b51b-75a4-49bc-ae06-cea8569d874e">
<img width="1078" alt="CoverageReport" src="https://github.com/user-attachments/assets/a08843fc-ee64-4cb8-94a8-04553573816e">

  
## Conclusion

This Weather App is a fully functional iOS app providing current weather data and a 5-day forecast using real-time API integration. The app follows the MVVM architecture for clean, modular, and testable code.
