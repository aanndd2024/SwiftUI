//
//  CoinDataService.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

import Foundation

//CG-NQCFrkXKPXTFbzgJDdN1JRMf

protocol CoinServiceProtocol {
    func fetchCoins() async -> Result<[Coin], NetworkError>
    func fetchCoinDetails(for coinId: String) async -> Result<CoinDetails, NetworkError>
}

class CoinDataService: CoinServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCoins() async -> Result<[Coin], NetworkError> {
        let endpoint = Endpoint(
            path: "coins/markets",
            queryItems: [
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "per_page", value: "100")
            ]
        )
        return await networkService.request(endpoint)
    }
    
    func fetchCoinDetails(for coinId: String) async -> Result<CoinDetails, NetworkError> {
        let endpoint = Endpoint(
            path: "coins/\(coinId)",
            queryItems: [
                URLQueryItem(name: "localization", value: "false"),
                URLQueryItem(name: "tickers", value: "false"),
                URLQueryItem(name: "market_data", value: "true"),
                URLQueryItem(name: "community_data", value: "false"),
                URLQueryItem(name: "developer_data", value: "false"),
                URLQueryItem(name: "sparkline", value: "false")
            ]
        )
        
        return await networkService.request(endpoint)
    }
}
