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

class Webservice {
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



//func fetchNewsAsync(sourceId: String, url: URL?) async throws -> [NewsArticle] {
//    
//    try await withCheckedThrowingContinuation { continuation in
//        fetchNews(sourceId: sourceId, url: url) { result in
//            switch result {
//                case .success(let newsArticles):
//                    continuation.resume(returning: newsArticles)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//            }
//        }
//    }
//}
