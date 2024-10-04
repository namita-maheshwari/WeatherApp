//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Namita Maheshwari on 01/10/24.
//

import XCTest
@testable import WeatherApp


class WeatherViewModelTests: XCTestCase {
    
    var weatherViewModel: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        weatherViewModel = WeatherViewModel()
        
        // Sample JSON response as a Data object
        let jsonResponse = """
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
            """.data(using: .utf8)!
        
        // Decoding the JSON response into ForecastResponse object
        let decoder = JSONDecoder()
        do {
            let forecastResponse = try decoder.decode(ForecastResponse.self, from: jsonResponse)
            weatherViewModel.weatherData = forecastResponse
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    override func tearDown() {
        weatherViewModel = nil
        super.tearDown()
    }
    
    func testGetWeatherInfo_ReturnsAttributedString() {
        // Act
        let attributedString = weatherViewModel.getWeatherInfo()
        
        // Assert
        XCTAssertNotNil(attributedString)
        let expectedLocation = "Location: HAPUR, India\n"
        let expectedTemperature = "Temperature: 30.0°C\n"
        let expectedCondition = "Condition: Sunny\n"
        let expectedHumidity = "Humidity: 50%\n"
        let expectedLastUpdated = "Last Updated: 2024-10-01 12:00\n\n"
        
        let attributedStringValue = attributedString?.string
        
        XCTAssertTrue(attributedStringValue?.contains(expectedLocation) ?? false)
        XCTAssertTrue(attributedStringValue?.contains(expectedTemperature) ?? false)
        XCTAssertTrue(attributedStringValue?.contains(expectedCondition) ?? false)
        XCTAssertTrue(attributedStringValue?.contains(expectedHumidity) ?? false)
        XCTAssertTrue(attributedStringValue?.contains(expectedLastUpdated) ?? false)
    }
    
    func testGetWeatherInfo_ReturnsNilWhenWeatherDataIsNil() {
        // Arrange
        weatherViewModel.weatherData = nil
        
        // Act
        let attributedString = weatherViewModel.getWeatherInfo()
        
        // Assert
        XCTAssertNil(attributedString)
    }

    func testGetForecastInfo_withValidData() {
        // Given: A valid ForecastResponse
        let forecastResponse = ForecastResponse(
            location: Location(name: "City", region: "Region", country: "Country", lat: 0.0, lon: 0.0, tzID: "GMT", localtimeEpoch: 0, localtime: "2024-10-01 12:00"),
            current: CurrentWeather(lastUpdated: "2024-10-01 12:00", tempC: 25.0, isDay: 1, condition: Condition(text: "Sunny", icon: "", code: 1000), windMph: 10.0, humidity: 60),
            forecast: Forecast(forecastday: [
                ForecastDay(date: "2024-10-02", day: DayWeather(maxtempC: 30.0, mintempC: 20.0, condition: Condition(text: "Partly Cloudy", icon: "", code: 1003))),
                ForecastDay(date: "2024-10-03", day: DayWeather(maxtempC: 28.0, mintempC: 18.0, condition: Condition(text: "Cloudy", icon: "", code: 1006))),
                ForecastDay(date: "2024-10-04", day: DayWeather(maxtempC: 29.0, mintempC: 19.0, condition: Condition(text: "Rain", icon: "", code: 1009))),
                ForecastDay(date: "2024-10-05", day: DayWeather(maxtempC: 27.0, mintempC: 17.0, condition: Condition(text: "Thunderstorms", icon: "", code: 1087))),
                ForecastDay(date: "2024-10-06", day: DayWeather(maxtempC: 26.0, mintempC: 16.0, condition: Condition(text: "Sunny", icon: "", code: 1000)))
            ])
        )
        
        // Set the weather data in the view model
        weatherViewModel.weatherData = forecastResponse
        
        // When: Calling getForecastInfo
        let forecastInfo = weatherViewModel.getForecastInfo()
        
        // Then: The forecast information should not be nil and should contain the expected strings
        XCTAssertNotNil(forecastInfo)
        
        let forecastString = forecastInfo?.string
        
        XCTAssertTrue(forecastString?.contains("5-DAY FORECAST") ?? false)
        XCTAssertTrue(forecastString?.contains("2024-10-02") ?? false)
        XCTAssertTrue(forecastString?.contains("Max Temp: 30.0°C, Min Temp: 20.0°C") ?? false)
        XCTAssertTrue(forecastString?.contains("Condition: Partly Cloudy") ?? false)
        XCTAssertTrue(forecastString?.contains("2024-10-03") ?? false)
        XCTAssertTrue(forecastString?.contains("Max Temp: 28.0°C, Min Temp: 18.0°C") ?? false)
        XCTAssertTrue(forecastString?.contains("Condition: Cloudy") ?? false)
    }
    
    func testGetForecastInfo_withNilData() {
        // Given: No weather data
        weatherViewModel.weatherData = nil
        
        // When: Calling getForecastInfo
        let forecastInfo = weatherViewModel.getForecastInfo()
        
        // Then: The forecast information should be nil
        XCTAssertNil(forecastInfo)
    }
}

