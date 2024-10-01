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
}

