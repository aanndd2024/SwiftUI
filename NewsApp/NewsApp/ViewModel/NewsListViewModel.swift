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
    
    private let webService: Webservice
    
    init(webService: Webservice) {
        self.webService = webService
    }
    
    func fetchNewsSourceData() async {
        isLoading = true
        let result = await webService.fetchSources(url: Constants.Urls.sources)
        switch result {
        case .success(let newsSourceData):
            self.newsSourceData = newsSourceData
        case .failure(let error):
            self.error = error
        }
        isLoading = false
    }
}
