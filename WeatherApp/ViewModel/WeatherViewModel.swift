//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Namita Maheshwari on 01/10/24.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    private var weatherService: WeatherService
    var weatherData: ForecastResponse?
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // Fetch weather data for a given city
    func fetchWeather(for city: String, completion: @escaping (Result<Void, Error>) -> Void) {
        weatherService.getWeather(for: city) { [weak self] result in
            switch result {
            case .success(let data):
                self?.weatherData = data
                completion(.success(())) // Notify success
            case .failure(let error):
                completion(.failure(error)) // Notify failure
            }
        }
    }
    
    // Returns formatted weather information for display
    func getWeatherInfo() -> NSAttributedString? {
        guard let weatherResponse = weatherData else { return nil }
        
        let location = weatherResponse.location
        let currentWeather = weatherResponse.current
        
        let weatherAttributedString = NSMutableAttributedString()
        
        let locationText = NSAttributedString(
            string: "Location: \(location.name.uppercased()), \(location.country)\n",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                         NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        weatherAttributedString.append(locationText)
        
        let temperatureText = NSAttributedString(
            string: "Temperature: \(currentWeather.tempC)°C\n",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                         NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        weatherAttributedString.append(temperatureText)
        
        let conditionText = NSAttributedString(
            string: "Condition: \(currentWeather.condition.text)\n",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        weatherAttributedString.append(conditionText)
        
        let humidityText = NSAttributedString(
            string: "Humidity: \(currentWeather.humidity)%\n",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        weatherAttributedString.append(humidityText)
        
        let lastUpdatedText = NSAttributedString(
            string: "Last Updated: \(currentWeather.lastUpdated)\n\n",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                         NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        weatherAttributedString.append(lastUpdatedText)
        
        return weatherAttributedString
    }
    
    // Returns formatted forecast information for display
    func getForecastInfo() -> NSAttributedString? {
        guard let weatherResponse = weatherData else { return nil }
        
        let forecastAttributedString = NSMutableAttributedString()
        
        let forecastHeaderText = NSAttributedString(
            string: "5-DAY FORECAST\n\n",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                         NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        forecastAttributedString.append(forecastHeaderText)
        
        for day in weatherResponse.forecast.forecastday {
            let dateText = NSAttributedString(
                string: "\(day.date)\n",
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                             NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
            )
            forecastAttributedString.append(dateText)
            
            let tempText = NSAttributedString(
                string: "Max Temp: \(day.day.maxtempC)°C, Min Temp: \(day.day.mintempC)°C\n",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                             NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            )
            forecastAttributedString.append(tempText)
            
            let conditionText = NSAttributedString(
                string: "Condition: \(day.day.condition.text)\n\n",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                             NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
            )
            forecastAttributedString.append(conditionText)
        }
        
        return forecastAttributedString
    }
}
