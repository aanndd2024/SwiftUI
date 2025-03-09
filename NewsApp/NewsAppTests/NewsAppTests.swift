//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Anand Yadav on 07/03/25.
//

import XCTest
@testable import NewsApp

@MainActor
final class NewsAppTests: XCTestCase {
    
    var viewModel: NewsListViewModel!
    var newsSourceListViewModel: NewsSourceListViewModel!

    var mockWebservice: MockWebservice!
    
    override func setUp() {
        super.setUp()
        mockWebservice = MockWebservice()
        viewModel = NewsListViewModel(webService: mockWebservice)
        newsSourceListViewModel = NewsSourceListViewModel(webService: mockWebservice)
    }
    
    override func tearDown() {
        viewModel = nil
        newsSourceListViewModel = nil
        mockWebservice = nil
        super.tearDown()
    }
    
    func testFetchNewsSourceData_Success() async {
        // Arrange
        let mockData = [NewsSource(id: "1", name: "Mock News", description: "Description")]
        mockWebservice.mockNewsSources = mockData
        
        // Act
        await viewModel.fetchNewsSourceData()
        
        // Assert
        XCTAssertEqual(viewModel.newsSourceData.count, 1)
        XCTAssertEqual(viewModel.newsSourceData.first?.id, "1")
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchNewsSourceData_BadUrlError() async {
        // Arrange
        mockWebservice.shouldReturnError = .badUrl
        
        // Act
        await viewModel.fetchNewsSourceData()
        
        // Assert
        XCTAssertTrue(viewModel.newsSourceData.isEmpty)
        //XCTAssertEqual(viewModel.error, .badUrl)
    }
    
    // Test - NewsSourceListViewModel
    func testFetchNewsArticleData_Success() async {
        // Arrange: Provide mock data
        let mockData = [NewsArticle(source: ["abc-news":"abc news"], author: "Emily Chang", title: "Test News", description: "final warning", url: "https://abcnews.go.com/", urlToImage: "https://i.abcnewsfe.com/", publishedAt: "2025-03-07T19:44:05Z", content: "President Donald Trump this week once again threatened Hamas")]
        mockWebservice.mockNewsArticles = mockData
        
        // Act: Call fetchNewsSourceData
        await newsSourceListViewModel.fetchNewsSourceData(sourceID: "abc-news")
        
        // Assert: Check if data is assigned correctly
        XCTAssertEqual(newsSourceListViewModel.newsArticles.count, 1)
        XCTAssertEqual(newsSourceListViewModel.newsArticles.first?.title, "Test News")
        XCTAssertNil(newsSourceListViewModel.error)
    }
    
    func testFetchNewsArticleData_BadUrlError() async {
        // Arrange: Simulate a bad URL error
        mockWebservice.shouldReturnError = .badUrl
        
        // Act
        await newsSourceListViewModel.fetchNewsSourceData(sourceID: "abc-news")
        
        // Assert
        XCTAssertTrue(newsSourceListViewModel.newsArticles.isEmpty)
        //XCTAssertEqual(newsSourceListViewModel.error, .badUrl)
    }
    
    func testFetchNewsArticleData_InvalidResponseError() async {
        // Arrange: Simulate an invalid response error
        mockWebservice.shouldReturnError = .invalidResponse
        
        // Act
        await newsSourceListViewModel.fetchNewsSourceData(sourceID: "abc-news")
        
        // Assert
        XCTAssertTrue(newsSourceListViewModel.newsArticles.isEmpty)
       // XCTAssertEqual(newsSourceListViewModel.error, .invalidResponse)
    }
    
    func testFetchNewsArticleData_DecodingError() async {
        // Arrange: Simulate a decoding error
        mockWebservice.shouldReturnError = .decodingError
        
        // Act
        await newsSourceListViewModel.fetchNewsSourceData(sourceID: "abc-news")
        
        // Assert
        XCTAssertTrue(newsSourceListViewModel.newsArticles.isEmpty)
        //XCTAssertEqual(newsSourceListViewModel.error, .decodingError)
    }
}
