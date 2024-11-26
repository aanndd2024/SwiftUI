//
//  WeatherService.swift
//  Weather
//
//  Created by Anand Yadav on 24/10/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchCoordinateByCity(city: String) async -> Result<Location, NetworkError>
    func fetchWeather(location: Location) async -> Result<Weather?, NetworkError>
}

enum NetworkError:Error {
    case invalidResponse
    case decodingError
}

struct WeatherService:WeatherServiceProtocol {
    func fetchCoordinateByCity(city: String) async -> Result<Location, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endPointURL(for: .coordinateByLocation(city)))
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(NetworkError.invalidResponse)
            }
            let locations = try JSONDecoder().decode([Location].self, from: data)
            return .success(locations.first!)
        } catch {
            return .failure(NetworkError.invalidResponse)
        }
    }
    
    func fetchWeather(location: Location) async -> Result<Weather?, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endPointURL(for: .weatherByLocation(location.lat, location.lon)))
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(NetworkError.invalidResponse)
            }
            guard let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                return .failure(.decodingError)
            }
            return .success(weatherResponse.main)
        } catch {
            return .failure(NetworkError.invalidResponse)
        }
    }
    
//    func getCoordinateByCity(city: String) async throws -> Location? {
//        let endpoint = APIEndpoint.endPointURL(for: .coordinateByLocation(city))
//        
//        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endPointURL(for: .coordinateByLocation(city)))
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//        
//        let locations = try JSONDecoder().decode([Location].self, from: data)
//        return locations.first
//    }
//    
//    func fetchWeather(location: Location) async throws -> Weather? {
//        
//        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endPointURL(for: .weatherByLocation(location.lat, location.lon)))
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//        
//        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
//        return weatherResponse.main 
//    }
}
