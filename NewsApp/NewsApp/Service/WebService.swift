//
//  WebService.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case decodingError
    case networkError(Error)
}
protocol WebserviceProtocol {
    func fetchSources(url: URL?) async -> Result<[NewsSource], NetworkError>
    func fetchNewsByID(sourceID: String, url: URL?) async -> Result<NewsArticleResponse, NetworkError>
}

class Webservice:WebserviceProtocol {
    func fetchSources(url: URL?) async -> Result<[NewsSource], NetworkError> {
        guard let url = url else {
            return .failure(.badUrl)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.invalidResponse)
            }
            let newsSource = try JSONDecoder().decode(NewsSourceResponse.self, from: data)
            return .success(newsSource.sources)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    func fetchNewsByID(sourceID: String, url: URL?) async -> Result<NewsArticleResponse, NetworkError> {
        guard let url = url else {
            return .failure(.badUrl)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.invalidResponse)
            }
            let newsSource = try JSONDecoder().decode(NewsArticleResponse.self, from: data)
            return .success(newsSource)
        } catch {
            return .failure(.decodingError)
        }
    }
}

