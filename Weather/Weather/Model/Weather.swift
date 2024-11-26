//
//  Weather.swift
//  Weather
//
//  Created by Anand Yadav on 24/10/24.
//

struct WeatherResponse: Decodable {
    let main:Weather
}

struct Weather:Decodable {
    let temp:Double
}
