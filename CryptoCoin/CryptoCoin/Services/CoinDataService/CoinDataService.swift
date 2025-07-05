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
        return await networkService.request([Coin].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(for coinId: String) async -> Result<CoinDetails, NetworkError> {
        // ✅ Try to return from cache first
            if let cached = CoinDetailsCache.shared.get(for: coinId) {
                print("✅ From Cached \(coinId)")
                return .success(cached)
            }
        
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
        
        let result = await networkService.request(CoinDetails.self, endpoint: endpoint)
        print("✅ From Backend \(coinId)")

        // 💾 Store in cache if success
        if case .success(let details) = result {
            CoinDetailsCache.shared.set(details, for: coinId)
        }
        return result
    }
}
