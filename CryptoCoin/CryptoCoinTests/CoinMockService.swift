//
//  CoinMockService.swift
//  CryptoCoinTests
//
//  Created by Anand Yadav on 22/06/25.
//

import Foundation
@testable import CryptoCoin

class MockCoinServiceSuccess: CoinServiceProtocol {
    func fetchCoins() async -> Result<[Coin], CoinError> {
        return .success([
            Coin(id: "bitcoin", name: "Bitcoin", symbol: "btc", image: "", current_price: 60000, price_change_percentage_24h: 2.5),
            Coin(id: "ethereum", name: "Ethereum", symbol: "eth", image: "", current_price: 3000, price_change_percentage_24h: -2.3)
        ])
    }
}

class MockCoinServiceFailure: CoinServiceProtocol {
    func fetchCoins() async -> Result<[Coin], CoinError> {
        return .failure(.invalidResponse)
    }
}
