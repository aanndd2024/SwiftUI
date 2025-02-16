//
//  NetworkManager.swift
//  CocktailBook
//
//  Created by Anand Yadav on 13/02/25.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case customError(String)
}

protocol NetworkManagerProtocol {
    func fetchCocktails() async throws -> [Cocktail]
}
class NetworkManager:NetworkManagerProtocol {
    static var shared = NetworkManager()
    private init() {}
    
    func fetchCocktails() async throws -> [Cocktail] {
        guard let url = Bundle.main.url(forResource: "CocktailData", withExtension: "json") else {
            throw NetworkError.invalidURL
        }
        do {
            let jsonData = try Data(contentsOf: url)
            let response = try JSONDecoder().decode([Cocktail].self, from: jsonData)
            return response
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    
}
