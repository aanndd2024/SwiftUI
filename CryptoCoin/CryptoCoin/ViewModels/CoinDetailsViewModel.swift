//
//  CoinDetailsViewModel.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 24/06/25.
//
import Foundation

@MainActor
class CoinDetailsViewModel: ObservableObject {
    @Published var coinsDetails: CoinDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let coinService: CoinServiceProtocol
    private let coinID: String
    
    init(coinID: String, service: CoinServiceProtocol = CoinDataService()) {
        self.coinID = coinID
        self.coinService = service
    }
    
    func fetchCoinDetails() async {
        guard coinsDetails == nil else { return } // ✅ Already fetched
        isLoading = true
        errorMessage = nil
        
        let result = await coinService.fetchCoinDetails(for: coinID)
        isLoading = false
        
        switch result {
        case .success(let coinDetails):
            //print("✅ CoinDetails:", coinDetails)
            self.coinsDetails = coinDetails
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
