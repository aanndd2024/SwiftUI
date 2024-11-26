//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anand Yadav on 24/10/24.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel:ObservableObject {
    @Published var weather:Weather?
    @Published var error: NetworkError?
    @Published var isLoading: Bool = false
    @Published var location:Location?

    private let weatherService:WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func fetchCoordinateByCity(city:String) async {
        let result = await weatherService.fetchCoordinateByCity(city: city)
        switch result {
        case .success(let location):
            print(location)
            self.location = location
        case .failure(let error):
            self.error = error
        }
    }
    
    func fetchWeather(location:Location) async {
        isLoading = true
        let result = await weatherService.fetchWeather(location: location)
        switch result {
        case .success(let weather):
            print(weather)
            self.weather = weather!
        case .failure(let error):
            self.error = error
        }
        isLoading = false
    }
}

