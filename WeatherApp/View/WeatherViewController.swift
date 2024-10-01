//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Namita Maheshwari on 01/10/24.
//


import UIKit

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    private let loader = UIActivityIndicatorView(style: .large)

    let headerLabel: UILabel = {
        let label = PaddedLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Weather App"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let weatherLabel: UILabel = {
        let label = PaddedLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let forecastLabel: UILabel = {
        let label = PaddedLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.title = "Weather App"
    }
    
    func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(cityTextField)
        view.addSubview(weatherLabel)
        view.addSubview(forecastLabel)
        
        searchButton.addTarget(self, action: #selector(searchWeather), for: .touchUpInside)
        view.addSubview(searchButton)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cityTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityTextField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            
            weatherLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           
            forecastLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            forecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func searchWeather() {
        loader.startAnimating() // Start the loader
        guard let city = cityTextField.text, !city.isEmpty else {
            print("Please enter a city name")
            return
        }
        
        viewModel.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.loader.stopAnimating() // Stop the loader
                switch result {
                case .success:
                    self.updateUI()
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                    self.weatherLabel.text = "Could not retrieve weather data. Please try again."
                }
            }
        }
    }
    
    func updateUI() {
        // Update weather data
        if let weatherText = viewModel.getWeatherInfo() {
            weatherLabel.attributedText = weatherText
            weatherLabel.backgroundColor = UIColor.systemMint
            weatherLabel.layer.cornerRadius = 10
            weatherLabel.clipsToBounds = true
        }
        
        // Update forecast data
        if let forecastText = viewModel.getForecastInfo() {
            forecastLabel.attributedText = forecastText
            forecastLabel.backgroundColor = UIColor.systemGray6
            forecastLabel.layer.cornerRadius = 10
            forecastLabel.clipsToBounds = true
        }
    }
}
