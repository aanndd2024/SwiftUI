//
//  APIEndpoint.swift
//  Weather
//
//  Created by Anand Yadav on 24/10/24.
//
import Foundation

enum APIEndpoint {
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinateByLocation(String)
    case weatherByLocation(Double, Double)
    
    private var path:String {
        switch self {
        case .coordinateByLocation(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constant.keys.weatherAPIKey)"
        case .weatherByLocation(let lat, let long):
            return "/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(Constant.keys.weatherAPIKey)&units=\(Constant.keys.unit)"
        }
    }
    
    static func endPointURL(for endPoint:APIEndpoint) -> URL {
        let endPointPath = endPoint.path
        return URL(string:baseURL+endPointPath)!
    }
}
