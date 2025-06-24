//
//  CoinDataService.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

import Foundation

//CG-NQCFrkXKPXTFbzgJDdN1JRMf

enum CoinError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError(Error)
    case networkError(Error)
}

protocol CoinServiceProtocol {
    func fetchCoins() async -> Result<[Coin], CoinError>
    func fetchCoinDetails(for coinId:String) async -> Result<CoinDetails, CoinError>
}

class CoinDataService: CoinServiceProtocol {
    private let baseURL = "https://api.coingecko.com/api/v3/coins/markets"

    func fetchCoins() async -> Result<[Coin], CoinError> {
        guard let url = URL(string: "\(baseURL)?vs_currency=usd&order=market_cap_desc") else {
            return .failure(.invalidURL)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(.invalidResponse)
            }
            
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return .success(coins)
        } catch let error as DecodingError {
            return .failure(.decodingError(error))
        } catch {
            return .failure(.networkError(error))
        }
    }
    
    func fetchCoinDetails(for coinId:String) async -> Result<CoinDetails, CoinError> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false") else {
            return .failure(.invalidURL)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(.invalidResponse)
            }
            
            let coinsDetails = try JSONDecoder().decode(CoinDetails.self, from: data)
            return .success(coinsDetails)
        } catch let error as DecodingError {
            return .failure(.decodingError(error))
        } catch {
            return .failure(.networkError(error))
        }
    }
}
