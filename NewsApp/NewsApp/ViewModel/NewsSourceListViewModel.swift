//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//
import Foundation
import Combine

@MainActor
class NewsSourceListViewModel: ObservableObject {
    @Published var newsArticles:[NewsArticle] = []
    @Published var error: NetworkError?
    @Published var isLoading: Bool = false
    
    private let webService: WebserviceProtocol
    
    init(webService: WebserviceProtocol) {
        self.webService = webService
    }
    
    func fetchNewsSourceData(sourceID:String) async {
        isLoading = true
        let result = await webService.fetchNewsByID(sourceID: sourceID, url: Constants.Urls.topHeadlines(by: sourceID))
        switch result {
        case .success(let newsArticles):
            self.newsArticles = newsArticles.articles
            print(self.newsArticles)
        case .failure(let error):
            self.error = error
        }
        isLoading = false
    }
}
