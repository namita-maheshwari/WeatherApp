//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Namita Maheshwari on 01/10/24.
//

import Foundation

//API Key : 7f3853a85ef941f2bed71713240110
class WeatherService {
    let apiKey = "7f3853a85ef941f2bed71713240110"
    
    func getWeather(for city: String, completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=5&aqi=no&alerts=no"

            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                    completion(.success(forecastResponse))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
}
