//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//
import Foundation
import Combine

@MainActor
class NewsListViewModel:ObservableObject {
    @Published var newsSourceData:[NewsSource] = []
    @Published var error: NetworkError?
    @Published var isLoading: Bool = false
    
    private let webService: WebserviceProtocol
    
    init(webService: WebserviceProtocol) {
        self.webService = webService
    }
    
    func fetchNewsSourceData() async {
        isLoading = true
        newsSourceData = []  // Clears old data before fetching
        
        let result = await webService.fetchSources(url: Constants.Urls.sources)
        
        switch result {
        case .success(let newsSources):
            self.newsSourceData = newsSources
            print(newsSources)
        case .failure(let error):
            self.error = error
        }
        isLoading = false
    }
}
