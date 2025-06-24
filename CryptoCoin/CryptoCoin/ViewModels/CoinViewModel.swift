//
//  CoinViewModel.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

import Foundation

@MainActor
class CoinViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let coinService: CoinServiceProtocol
    
    init(service: CoinServiceProtocol = CoinDataService()) {
        self.coinService = service
    }
    
    func fetchCoins() async {
        isLoading = true
        errorMessage = nil
        
        let result = await coinService.fetchCoins()
        isLoading = false
        switch result {
        case .success(let coins):
            print("✅ Coins:",coins)
            self.coins = coins
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
