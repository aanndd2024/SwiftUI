//
//  MockService.swift
//  NewsApp
//
//  Created by Anand Yadav on 08/03/25.
//
import XCTest
@testable import NewsApp

class MockWebservice: WebserviceProtocol {
    var shouldReturnError: NetworkError?
    var mockNewsSources: [NewsSource] = []
    var mockNewsArticles: [NewsArticle] = []

    
    func fetchNewsByID(sourceID: String, url: URL?) async -> Result<NewsArticleResponse, NetworkError> {
        if let error = shouldReturnError {
            return .failure(error)
        }
        return .success(NewsArticleResponse(articles: mockNewsArticles))
    }
    
    func fetchSources(url: URL?) async -> Result<[NewsSource], NetworkError> {
        if let error = shouldReturnError {
            return .failure(error)
        }
        return .success(mockNewsSources)
    }
}
