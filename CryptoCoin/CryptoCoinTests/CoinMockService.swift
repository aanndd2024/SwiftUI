//
//  CoinMockService.swift
//  CryptoCoinTests
//
//  Created by Anand Yadav on 22/06/25.
//

import Foundation
@testable import CryptoCoin

class MockCoinServiceSuccess: CoinServiceProtocol {
    func fetchCoinDetails(for coinId: String) async -> Result<CryptoCoin.CoinDetails, CryptoCoin.NetworkError> {
        return .success(
            CoinDetails(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "btc",
                description: CoinDetails.Description(
                    en: "Bitcoin is a decentralized cryptocurrency that uses peer-to-peer technology to operate without a central authority."
                ),
                image: CoinDetails.Image(
                    large: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png"
                ),
                market_data: CoinDetails.MarketData(
                    current_price: ["usd": 67890.12, "eur": 62400.56],
                    price_change_percentage_24h: 2.34,
                    market_cap: ["usd": 1320000000000, "eur": 1210000000000]
                )
            )
        )
    }
    
    func fetchCoins() async -> Result<[CryptoCoin.Coin], CryptoCoin.NetworkError> {
        return .success([
            Coin(id: "bitcoin", name: "Bitcoin", symbol: "btc", image: "", current_price: 60000, price_change_percentage_24h: 2.5),
            Coin(id: "ethereum", name: "Ethereum", symbol: "eth", image: "", current_price: 3000, price_change_percentage_24h: -2.3)
        ])
    }
}

class MockCoinServiceFailure: CoinServiceProtocol {
    func fetchCoins() async -> Result<[CryptoCoin.Coin], CryptoCoin.NetworkError> {
        return .success([
            Coin(id: "bitcoin", name: "Bitcoin", symbol: "btc", image: "", current_price: 60000, price_change_percentage_24h: 2.5),
            Coin(id: "ethereum", name: "Ethereum", symbol: "eth", image: "", current_price: 3000, price_change_percentage_24h: -2.3)
        ])
    }
    
    func fetchCoinDetails(for coinId: String) async -> Result<CryptoCoin.CoinDetails, CryptoCoin.NetworkError> {
        return .failure(.invalidData)
    }
}
